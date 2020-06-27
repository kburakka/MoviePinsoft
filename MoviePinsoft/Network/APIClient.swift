//
//  APIClient.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import Alamofire


class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping ((Result<T, AFError>)?,Result<ErrorResponse, AFError>?)->Void) -> DataRequest {
        let request = AF.request(route)
        return request.responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success( _):
                completion(response.result,nil)
            case .failure( _):
                request.responseDecodable { (response: DataResponse<ErrorResponse, AFError>) in
                    completion(nil,response.result)
                }
            }
        }
    }
    
    static func getSearchMovie(searchText : String, completion:@escaping (Result<Search, AFError>?,Result<ErrorResponse, AFError>?)->Void) {
        performRequest(route: APIRouter.search(text: searchText), completion: completion)
    }
}