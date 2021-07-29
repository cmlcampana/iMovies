//
//  Service.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

final class Service<Endpoint: EndpointType>: NetworkService {
    private var task: URLSessionTask?
    private let session: URLSession
    
    init (session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: EndpointType>(_ networkRequest: T, completion: @escaping (Response<T>) -> Void) {
        do {
            let request = try createRequest(endpoint: networkRequest)
            task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
                guard let self = self else { return }
                if let error = error {
                    completion(Response(statusCode: 500, result: .failure(error)))
                    return
                }
                
                let response = self.createResponse(networkRequest: networkRequest, response: response, data: data)
                completion(response)
            })
        } catch {
            completion(Response(statusCode: 500, result: .failure(error)))
        }
    }

    func cancel() {
        self.task?.cancel()
    }
    
    private func createRequest<T: EndpointType>(endpoint: T) throws -> URLRequest {
        var request = URLRequest(
            url: endpoint.baseURL.appendingPathComponent(endpoint.path),
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 10
        )
        
        request.httpMethod = endpoint.httpMethod.rawValue
        
        do {
            switch endpoint.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case let .requestParameters(bodyParameters, urlParameters):
                try configureParameters(bodyParams: bodyParameters, urlParams: urlParameters, request: &request)
            case let .requestParametersAndHeaders(bodyParameters, urlParameteres, headers):
                addAdditionalHeaders(headers, request: &request)
                try configureParameters(bodyParams: bodyParameters, urlParams: urlParameteres, request: &request)
            }
            
            return request
        } catch {
            throw error
        }
    }
    
    private func createResponse<T: EndpointType>(networkRequest: T,
                                                   response: URLResponse?,
                                                   data: Data?) -> Response<T> {
        guard let resp = response as? HTTPURLResponse else {
            return Response(statusCode: 500, result: .failure(NSError(domain: "Invalid response!", code: 800, userInfo: nil)))
        }

        if resp.statusCode > 299 {
            guard let errorData = data else {
                return Response(statusCode: resp.statusCode, result: .failure(NSError(domain: "Request error!", code: 801, userInfo: nil)))
            }

            do {
                guard let parsedResponseError = try networkRequest.parseError(data: errorData) else {
                    return Response(statusCode: resp.statusCode, result: .failure(NSError(domain: "Unable to decode response body!", code: 802, userInfo: nil)))
                }
                return Response(statusCode: resp.statusCode, result: .failure(parsedResponseError))
            } catch {
                return Response(statusCode: resp.statusCode, result: .failure(NSError(domain: "Unable to decode response body!", code: 802, userInfo: nil)))
            }
        }

        guard let responseData = data else {
            return Response(statusCode: resp.statusCode, result: .success(nil))
        }

        do {
            guard let parsedData = try networkRequest.parse(data: responseData) else {
                return Response(statusCode: resp.statusCode, result: .success(nil))
            }
            return Response(statusCode: resp.statusCode, result: .success(parsedData))
        } catch {
            return Response(statusCode: resp.statusCode, result: .failure(NSError(domain: "Unable to decode response body!", code: 802, userInfo: nil)))
        }
    }
    
    private func configureParameters(
        bodyParams: Parameters?,
        urlParams: Parameters?,
        request: inout URLRequest) throws {
        do {
            if let bodyParams = bodyParams {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParams)
            }
            
            if let urlParams = urlParams {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParams)
            }
        } catch {
            throw error
        }
    }
    
    private func addAdditionalHeaders(_ headers: HTTPHeader?, request: inout URLRequest) {
        guard let headers = headers else { return }
        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
