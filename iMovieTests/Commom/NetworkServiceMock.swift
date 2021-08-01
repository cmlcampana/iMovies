//
//  NetworkServiceMock.swift
//  iMovieTests
//
//  Created by Camila Campana on 01/08/21.
//

import XCTest
@testable import iMovie

final class NetworkServiceMock<T>: NetworkService {
    var successModel: T?
    var errorModel: NetworkError?
    
    func performRequest<T>(endpoint: EndpointType, using keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy, result: @escaping ResultHandler<T>) where T : Decodable {
        if let error = errorModel {
            result(.failure(error))
            return
        }

        result(.success(successModel as! T))
    }
}
