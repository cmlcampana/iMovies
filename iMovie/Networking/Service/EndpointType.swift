//
//  EndpointType.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public typealias Header = [String: String]
public typealias Parameters = [String: Any]
public typealias Body = [String: Any]

public protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: Header? { get }
    var parameters: Parameters? { get }
    var body: Body? { get }
}
