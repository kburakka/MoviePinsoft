//
//  APIRouter.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case search(text :String)
    case movieDetail(id: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        case .movieDetail:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .search(let text):
            return "&s=\(text)"
        case .movieDetail(let id):
            return "&i=\(id)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = ProductionServer.baseURL + path
        let url = try urlString.asURL()

        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        return urlRequest
    }
}
