//
//  ParameterEncoder.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
