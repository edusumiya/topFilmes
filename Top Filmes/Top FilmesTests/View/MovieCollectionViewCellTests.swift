//
//  MovieCollectionViewCellTests.swift
//  Top FilmesTests
//
//  Created by Eduardo Sumiya on 08/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import XCTest
@testable import Top_Filmes

class MovieCollectionViewCellTests: XCTestCase {
    
    var movieCollectionViewCell: MovieCollectionViewCell!
    var movie: MovieModel!
    
    override func setUp() {
        super.setUp()
        
        movie = MockParserHelper.getMovieMock()
        
        setupCreateMovieCollectionViewCell()
    }
    
    func setupCreateMovieCollectionViewCell()
    {
        movieCollectionViewCell = Bundle.main.loadNibNamed("MovieCollectionViewCell", owner: "self", options: nil)?.first as? MovieCollectionViewCell
        movieCollectionViewCell.movie = movie
    }
    
    func testInstance() {
        XCTAssert(movieCollectionViewCell != nil)
    }
    
    func testProperties() {
        XCTAssert(movieCollectionViewCell.movieDescriptionLabel?.text == movie.title)
    }
}
