//
//  NetworkError.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public enum NetworkError: String, Error, Equatable {
    case parametersNil = "Parameters nil"
    case encondingFailed = "Enconding failed"
    case missingURL = "Missing or invalid URL"
}
