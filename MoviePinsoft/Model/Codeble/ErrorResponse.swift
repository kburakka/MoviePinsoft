//
//  ErrorResponse.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    let Response: String
    let Error: String
}
