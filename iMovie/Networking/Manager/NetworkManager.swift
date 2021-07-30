//
//  NetworkManager.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public final class NetworkManager: NetworkService, RequestHandleResponsable {
    private let session: URLSession

    public init(session: URLSession = URLSession(configuration: URLSession.shared.configuration)) {
        self.session = session
    }

    public func performRequest<T: Decodable>(
        endpoint: EndpointType,
        using keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        result: @escaping ResultHandler<T>
    ) {

        guard let request = URLRequest(endpoint: endpoint) else { preconditionFailure("Fail on create request") }

        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                let response = response as? HTTPURLResponse

                self.handleResponse(
                    data: data,
                    keyDecodingStrategy: keyDecodingStrategy,
                    response: response,
                    error: error,
                    result: result
                )
            }
        }
        task.resume()
    }
}
