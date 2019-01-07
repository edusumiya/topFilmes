//
//  TopMoviesBusiness.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 07/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation
import Reachability

class TopMoviesBusiness: NSObject {
    // MARK: - TypeAlias
    typealias SuccessMovies = (_ resultMovie: MovieResultModel) -> Void
    typealias Failure = (_ error: Error) -> Void
    
    // MARK: - Blocks
    fileprivate var successMovies: (SuccessMovies)?
    fileprivate var failure: (Failure)?
    
    static func getMovies(page: Int, success: @escaping SuccessMovies, failure: @escaping Failure) {
        let reachability = Reachability()!
        
        switch reachability.connection {
        case .none:
            let movies = CoreDataRepository.getMoviesBackup()
            
            if movies.isEmpty {
                failure(NSError(domain: "Failed to retrieve Data From Database", code: 0, userInfo: nil))
                
                return
            }
            
            let movieResult = MovieResultModel()
            movieResult.results = movies
            success(movieResult)
        default:
            TopMoviesRepository.fetchTopMovies(page: page, success: { (movies) in
                CoreDataRepository.saveMoviesBackup(movies: movies.results ?? [MovieModel]())
                
                success(movies)
            }, failure: { (error) in
                failure(error)
            })
        }
    }
}
