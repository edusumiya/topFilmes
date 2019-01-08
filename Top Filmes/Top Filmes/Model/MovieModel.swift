//
//  MovieModel.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 06/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation

class MovieModel: Decodable {
    var id: Int?
    var vote_average: Float?
    var title: String?
    var poster_path: String?
    var popularity: Float?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]?
    var backdrop_path: String?
    var overview: String?
    var release_date: String?
    
    // MARK: - Image Data
    var posterImage: Data?
    var backDropImage: Data?
}
