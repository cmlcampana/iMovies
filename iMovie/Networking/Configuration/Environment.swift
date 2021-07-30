//
//  Environment.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

enum Environment {
    case qa
    case production
    case staging
    
    var baseURL: String {
        switch self {
        case .qa:
            return "https://qa.themoviedb.org"
        case .production:
            return "https://api.themoviedb.org"
        case .staging:
            return "https://staging.themoviedb.org"
        }
    }
    
    var apiKey: String {
        "365c0b8384162b60d9fb7ebf8dd0ae4c"
    }
}

enum Language: String, Equatable {
    case enUS = "en-US"
    case ptBR = "pt-BR"
}
