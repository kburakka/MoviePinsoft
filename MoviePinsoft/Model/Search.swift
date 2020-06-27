//
//  Search.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import Foundation

struct Search: Codable {
    let Search: [SearchMovie]
    let totalResults: String
    let Response: String
}
