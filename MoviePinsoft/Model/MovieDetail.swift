//
//  MovieDetail.swift
//  MoviePinsoft
//
//  Created by burak kaya on 27/06/2020.
//  Copyright © 2020 burak kaya. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    let Title: String
    let Year: String
    let Released: String
    let Genre: String
    let Runtime: String
    let Director: String
    let Actors: String
    let Plot: String
    let Language: String
    let Country: String
    let Awards: String
    let Poster: String
    let imdbRating: String
    let imdbID: String
}
