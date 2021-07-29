//
//  NetworkResponse.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public struct Response<T: EndpointType> {
    public var statusCode: Int
    public var result: Result<T.ModelType?, Error>
}

public struct ResponseData {
    public var statusCode: Int
    public var result: Result<Data?, Error>
}
