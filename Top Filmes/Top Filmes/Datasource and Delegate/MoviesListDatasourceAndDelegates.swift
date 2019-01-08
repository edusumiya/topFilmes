//
//  MoviesListDatasourceAndDelegates.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 06/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import UIKit

class MoviesListDatasourceAndDelegates: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Constants
    struct Constants {
        static let numberOfColumns: CGFloat = 3
        static let totalMargins: CGFloat = 20
        static let imageFactor: CGFloat = 1.6
    }
    
    // MARK: - Variables
    fileprivate var moviesCollectionView: UICollectionView!
    var infiniteScroll: Bool = true
    
    // MARK: - Model Object
    var moviesList: [MovieModel]?
    
    // MARK: - Delegate
    var delegate: MoviesListDelegate?
    
    // MARK: - Init
    init(moviesCollectionView: UICollectionView, moviesList: [MovieModel]?, delegate: MoviesListDelegate) {
        super.init()
        
        self.moviesCollectionView = moviesCollectionView
        self.moviesList = moviesList
        self.delegate = delegate
        
        configureCollection()
    }
    
    // MARK: - Collection Configuration
    func configureCollection() {
        MovieCollectionViewCell.register(moviesCollectionView)
        
        moviesCollectionView?.dataSource = self
        moviesCollectionView?.delegate = self
    }
    
    // MARK: - Methods
    
    /// Append movies list
    ///
    /// - Parameter newMoviesList: movies for append
    func appendMoviesList(newMoviesList: [MovieModel]) {
        moviesList?.append(contentsOf: newMoviesList)
    }
    
    /// Refresh the movies list
    ///
    /// - Parameter newMoviesList: movies for refresh
    func updateMoviesList(newMoviesList: [MovieModel]) {
        moviesList = newMoviesList
    }
    
    
    /// Returns the movies of dataSource
    ///
    /// - Returns: movies
    func requestMoviesList() -> [MovieModel]? {
        return moviesList
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MovieCollectionViewCell = collectionView.dequeue(index: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.movie = moviesList?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (moviesList?.count ?? 1) - 1 && infiniteScroll {
            delegate?.requestMoreMovies()
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = screenWidth/Constants.numberOfColumns - Constants.totalMargins
        let height = screenWidth/Constants.numberOfColumns * Constants.imageFactor
        
        return CGSize(width: width, height: height)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        delegate?.didSelectMovie(movie: moviesList?[indexPath.item] ?? MovieModel())
    }
    
    // MARK: - ScrollView
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if (actualPosition.y < 0){
            infiniteScroll = true
            delegate?.removeSearch()
        }
    }
}
