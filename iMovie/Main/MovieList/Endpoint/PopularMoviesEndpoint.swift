//
//  PopularMoviesEndpoint.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

final class PopularMoviesEndpoint: EndpointType {
    var baseURL: URL
    var path: String { "/3/movie/popular" }
    var method: HTTPMethod { .get }
    var header: Header? { nil }
    var parameters: Parameters?
    var body: Body? { nil }
    
    init(environment: Environment, language: String = Language.enUS.rawValue) {
        self.baseURL = URL(string: environment.baseURL)!
        self.parameters = [
            "api_key": environment.apiKey,
            "language": language
        ]
    }
}
