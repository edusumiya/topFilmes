//
//  Top_FilmesTests.swift
//  Top FilmesTests
//
//  Created by Eduardo Sumiya on 05/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import XCTest
@testable import Top_Filmes

class MoviesListViewControllerTests: XCTestCase {
    
    var moviesListViewController: MovieListViewController!
    var movies: MovieResultModel!
    
    override func setUp() {
        super.setUp()
        setupCreateMoviesListViewController()
        
        movies = MockParserHelper.getMoviesResponseMock()
        moviesListViewController.moviesDataSource = MoviesListDatasourceAndDelegates(moviesCollectionView: moviesListViewController.moviesCollectionView ?? UICollectionView(), moviesList: movies?.results, delegate: moviesListViewController)
    }
    
    func setupCreateMoviesListViewController()
    {
        let storyboard = UIStoryboard(name: "Movie", bundle: nil)
        moviesListViewController = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController
        _ = moviesListViewController.view
    }
    
    func testInstance() {
        XCTAssert(moviesListViewController != nil)
    }
    
    func testCollectionDatasourceMethods() {
        guard let dataSource = moviesListViewController.moviesDataSource, let collectionView = moviesListViewController.moviesCollectionView else {
            fatalError("Failed to retrieve datasource and collectionView")
        }
        
        XCTAssert(dataSource.collectionView(collectionView, numberOfItemsInSection: 0) == 20)
        
        XCTAssert(dataSource.collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0)).isKind(of: MovieCollectionViewCell.self))
    }
    
    func testDatasourceMethods() {
        guard let dataSource = moviesListViewController.moviesDataSource, let moviesResults = movies.results else {
            fatalError("Failed to retrieve items for testing")
        }
        
        dataSource.appendMoviesList(newMoviesList: moviesResults)
        XCTAssert(dataSource.moviesList?.count == 40)
        
        dataSource.updateMoviesList(newMoviesList: moviesResults)
        XCTAssert(dataSource.moviesList?.count == 20)
    }
}
