//
//  MovieDetailViewControllerTests.swift
//  Top FilmesTests
//
//  Created by Eduardo Sumiya on 08/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import XCTest
@testable import Top_Filmes

class MovieDetailViewControllerTests: XCTestCase {
    
    var movieDetailViewController: MovieDetailViewController?
    
    override func setUp() {
        super.setUp()
        setupCreateMovieDetailViewController()
    }
    
    func setupCreateMovieDetailViewController()
    {
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        
        movieDetailViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        movieDetailViewController?.movie = MockParserHelper.getMovieMock()
        
        _ = movieDetailViewController?.view
    }
    
    func testInstance() {
        XCTAssert(movieDetailViewController != nil)
    }
    
    func testModelObjects() {
        XCTAssert(movieDetailViewController?.movie?.id == 297802)
    }
    
    func testProperties() {
        XCTAssert(movieDetailViewController?.movieNameLabel.text == "Aquaman")
        XCTAssert(movieDetailViewController?.releaseDateLabel.text == "21/12/2018")
    }
    
}
