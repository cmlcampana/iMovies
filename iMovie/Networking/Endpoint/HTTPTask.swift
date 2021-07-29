//
//  HTTPTask.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public enum HTTPTask {
    case request
    case requestParameters(
            bodyParameters: Parameters?,
            urlParameters: Parameters?
         )
    case requestParametersAndHeaders(
            bodyParameters: Parameters?,
            urlParameteres: Parameters?,
            headers: HTTPHeader?
         )
}
