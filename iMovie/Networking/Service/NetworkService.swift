//
//  NetworkService.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public typealias ResultHandler<T> = (Result<T, NetworkError>) -> Void

public protocol NetworkService {
    func performRequest<T: Decodable>(endpoint: EndpointType, using keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy, result: @escaping ResultHandler<T>)
}
