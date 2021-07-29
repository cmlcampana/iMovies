//
//  EndpointType.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public typealias HTTPHeader = [String: String]

enum HTTPHeaderFields: String {
    case contentType = "Content-Type"
}

public typealias Parameters = [String: Any]

public enum ParameterEncoding {
    case jsonEncoding
    case urlEnconding
}

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

public protocol EndpointType {
    associatedtype ModelType: Decodable
    associatedtype ErrorModelType: Error, Decodable
    
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: HTTPHeader? { get set }
    var parameters: Parameters? { get set }
    var encoding: ParameterEncoding? { get set }
    var task: HTTPTask { get }
}

extension EndpointType {
    public func parse(data: Data) throws -> ModelType? {
        let model = try? JSONDecoder().decode(ModelType.self, from: data)
        return model
    }

    public func parseError(data: Data) throws -> ErrorModelType? {
        let model = try? JSONDecoder().decode(ErrorModelType.self, from: data)
        return model
    }
}
