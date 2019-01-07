//
//  MoviesListProtocol.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 07/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation

protocol MoviesListDelegate {
    /// Requests the next page of movies
    func requestMoreMovies()
    
    /// Requests searchView to disappear
    func removeSearch()

    /// Send the selected movie to view description
    ///
    /// - Parameter movie: movie selected
    func didSelectMovie(movie: MovieModel)
}
