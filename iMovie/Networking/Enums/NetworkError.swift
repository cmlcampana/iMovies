//
//  NetworkError.swift
//  iMovie
//
//  Created by Camila Campana on 30/07/21.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case custom(description: String)
    case unknown
    case parseError
    case noJSONData
    case noNetwork
    case requestTimeout
    case unauthorized
    case badRequest
    case outDated

    var localizedDescription: String {
        switch self {
        case let .custom(description):
            return description
        case .unknown, .parseError, .noJSONData, .badRequest, .outDated:
            return "Conection fail"
        case .requestTimeout, .noNetwork:
            return "Try again"
        case .unauthorized:
            return "Invalid data"
        }
    }

    public init(description: String) {
        self = .custom(description: description)
    }
}
