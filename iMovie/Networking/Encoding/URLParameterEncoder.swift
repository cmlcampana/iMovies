//
//  URLParameterEncoder.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else {
            throw NetworkError.missingURL
        }
        
        if var urlComponents = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false),
           !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            parameters.forEach { key, value in
                let item = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(item)
            }
            
            urlRequest.url = urlComponents.url
         }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
