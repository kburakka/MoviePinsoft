//
//  Constants.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
}

struct ProductionServer {
    static var MovieAPIKey = ""
    static let baseURL = "http://www.omdbapi.com/?apikey=\(MovieAPIKey)"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
