//
//  URLComponents+EndpointType.swift
//  iMovie
//
//  Created by Camila Campana on 30/07/21.
//

import Foundation

extension URLComponents {
    init?(endpoint: EndpointType) {
        self.init(url: endpoint.baseURL, resolvingAgainstBaseURL: true)
        path = endpoint.path

        guard let parameters = endpoint.parameters else {
            return
        }

        queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
