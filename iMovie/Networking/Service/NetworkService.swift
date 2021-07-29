//
//  NetworkService.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public protocol NetworkService {
    func request<T: EndpointType>(_ networkRequest: T, completion: @escaping (Response<T>) -> Void)
    func cancel()
}
