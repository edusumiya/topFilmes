//
//  MovieResultModel.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 06/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation

class MovieResultModel: Decodable {
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [MovieModel]?
}
