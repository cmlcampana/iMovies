//
//  HandleDataResponse.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public protocol HandleDataResponse: HandleJSONDecode {
    func handleDataResponse<T: Decodable>(
        data: Data,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
        response: HTTPURLResponse,
        result: ResultHandler<T>
    )
}

public extension HandleDataResponse {
    func handleDataResponse<T: Decodable>(
        data: Data,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy,
        response: HTTPURLResponse,
        result: ResultHandler<T>
    ) {
        switch response.statusCode {
        case 200...299:
            handleJSONDecode(
                data: data,
                keyDecodingStrategy: keyDecodingStrategy,
                result: result
            )
        case 400...499:
            result(.failure(.unauthorized))
        case 500...599:
            result(.failure(.badRequest))
        case 600:
            result(.failure(.outDated))
        default:
            result(.failure(.unknown))
        }
    }
}
