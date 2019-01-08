//
//  MockParserHelper.swift
//  Top FilmesTests
//
//  Created by Eduardo Sumiya on 08/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation
@testable import Top_Filmes
class MockParserHelper: NSObject {
    struct Constants {
        static let movieMockFile: String = "MovieMock"
        static let moviesListMockFile: String = "MoviesListMock"
        static let mockExtension: String = "json"
    }
    
    static func getMovieMock() -> MovieModel? {
        let url = Bundle.main.url(forResource: Constants.movieMockFile, withExtension: Constants.mockExtension)
        
        guard let jsonData = url else {return nil}
        guard let data = try? Data(contentsOf: jsonData) else { return nil}
        guard let movie = try? JSONDecoder().decode(MovieModel.self, from: data) else {return nil}

        return movie
    }
    
    static func getMoviesResponseMock() -> MovieResultModel? {
        let url = Bundle.main.url(forResource: Constants.moviesListMockFile, withExtension: Constants.mockExtension)
        
        guard let jsonData = url else {return nil}
        guard let data = try? Data(contentsOf: jsonData) else { return nil}
        guard let movie = try? JSONDecoder().decode(MovieResultModel.self, from: data) else {return nil}
        
        return movie
    }
}
