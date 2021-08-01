//
//  UpcomingMoviesEndpoint.swift
//  iMovie
//
//  Created by Camila Campana on 01/08/21.
//

import Foundation

final class UpcomingMoviesEndpoint: EndpointType {
    var baseURL: URL
    var path: String { "/3/movie/upcoming" }
    var method: HTTPMethod { .get }
    var header: Header? { nil }
    var parameters: Parameters?
    var body: Body? { nil }
    
    init(environment: Environment, page: Int, language: String = Language.enUS.rawValue) {
        self.baseURL = URL(string: environment.baseURL)!
        self.parameters = [
            "api_key": environment.apiKey,
            "language": language,
            "page": page
        ]
    }
}
