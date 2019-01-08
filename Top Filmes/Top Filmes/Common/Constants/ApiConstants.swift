//
//  ApiConstants.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 06/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation

struct ApiConstants {
    // MARK: - URLs
    static let apiUrl: String = "https://api.themoviedb.org/3/"
    static let image200Url: String = "https://image.tmdb.org/t/p/w200/"
    static let image300Url: String = "https://image.tmdb.org/t/p/w300/"
    static let imageOriginalUrl: String = "https://image.tmdb.org/t/p/original/"
    
    // MARK: - Endpoints
    static let discoverEndpoint: String = "discover/movie"
    
    // MARK: - Params
    static let apiKeyParam: String = "api_key"
    static let pageParam: String = "page"
    static let sortParam: String = "sort_by"
    
    // MARK: - Values
    static let apiKeyValue: String = "983eb3ff9cf5fc594d7cee4eebbed875"
    static let sortValue: String = "popularity.desc"
}
