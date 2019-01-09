//
//  ViewController.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 05/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import UIKit
import Reachability

class MovieListViewController: UIViewController, MoviesListDelegate {
    struct Constants {
        static let storyboardName: String = "Movie"
        static let movieDetailViewControllerName = "MovieDetailViewController"
    }
    // MARK: - Properties
    @IBOutlet var moviesCollectionView: UICollectionView!
    @IBOutlet var searchView: UIView!
    @IBOutlet var searchViewHeight: NSLayoutConstraint!
    private var searchController: UISearchController!
    private let refreshControl = UIRefreshControl()

    // MARK: - DataSource
    var moviesDataSource: MoviesListDatasourceAndDelegates?

    // MARK: - Internet Connection
    let reachability = Reachability()!
    
    // MARK: - Variables
    fileprivate var currentPage: Int = 1
    fileprivate var totalPages: Int = 1
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        requestData(page: currentPage, pullRequest: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        
        try? reachability.startNotifier()
    }
    
    // MARK: - Configuration Methods
    fileprivate func configureUI() {
        self.navigationItem.title = Localization.movieListViewControllerTitle.localized
        
        configureSearch()
    }
    
    fileprivate func configureRefreshControl() {
        refreshControl.tintColor = .white
        moviesCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshMoviesList(_:)), for: .valueChanged)
    }
    
    fileprivate func configureSearch() {
        searchController = UISearchController(searchResultsController:  nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = UIBarStyle.blackTranslucent
        
        definesPresentationContext = true
    }
    
    // MARK: - Data Request
    fileprivate func requestData(page: Int, pullRequest: Bool) {
        TopMoviesBusiness.getMovies(page: page, success: {(movies) in
            if let moviesResults = movies.results {
                if self.moviesDataSource == nil {
                    self.moviesDataSource = MoviesListDatasourceAndDelegates(moviesCollectionView: self.moviesCollectionView, moviesList: moviesResults, delegate: self)
                } else {
                    if pullRequest {
                        self.moviesDataSource?.updateMoviesList(newMoviesList: movies.results ?? [MovieModel]())
                        self.moviesCollectionView.reloadData()
                    } else {
                        if self.currentPage == movies.page {
                            self.moviesDataSource?.appendMoviesList(newMoviesList: movies.results ?? [MovieModel]())
                            self.moviesCollectionView.reloadData()
                        }
                    }
                }
                
                self.currentPage = movies.page ?? 1
                self.totalPages = movies.total_pages ?? 1
                
                self.configureRefreshControl()
                
                self.refreshControl.endRefreshing()
            }
        }) { (error) in
            print(error)
        }
    }
    
    // MARK: - Refresh Control
    @objc private func refreshMoviesList(_ sender: Any) {
        currentPage = 1
        requestData(page: currentPage, pullRequest: true)
    }
    
    // MARK: - Listeners
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .none:
            MessageUtils.showToast(controller: self, message: Localization.warningLostConnection.localized, seconds: 1)
        default:
            return
        }
    }
    
    // MARK: - MoviesListDelegate
    func requestMoreMovies() {
        if currentPage < totalPages {
            currentPage += 1
        }
        
        requestData(page: currentPage, pullRequest: false)
    }
    
    func removeSearch() {
        animateSearchAppearance(showSearch: false)
    }
    
    func didSelectMovie(movie: MovieModel) {
        let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
        guard let movieDetailViewController = storyboard.instantiateViewController(withIdentifier: Constants.movieDetailViewControllerName) as? MovieDetailViewController else {
            return
        }
        
        movieDetailViewController.movie = movie
        
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

// MARK: - Search Management
extension MovieListViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        
        if searchText?.isEmpty ?? true {
            moviesDataSource?.updateMoviesList(newMoviesList: CoreDataRepository.getMoviesBackup())
        } else {
            let filteredMovies = CoreDataRepository.getMoviesBackup().filter({return $0.title?.localizedCaseInsensitiveContains(searchText ?? "") ?? false})
            moviesDataSource?.updateMoviesList(newMoviesList: filteredMovies)
        }
        
        moviesCollectionView.reloadData()
    }
    
    // MARK: - Search Control
    @IBAction func showSearchBar(_ sender: Any) {
        let showSearch = (searchViewHeight.constant == 0)
        animateSearchAppearance(showSearch: showSearch)
        moviesDataSource?.infiniteScroll = !showSearch
    }
    
    fileprivate func animateSearchAppearance(showSearch: Bool) {
        if showSearch {
            UIView.animate(withDuration: 0.5, animations: {
                self.searchViewHeight.constant = 60
                self.view.layoutIfNeeded()
            }) { (completion) in
                self.searchView.addSubview(self.searchController.searchBar)
            }
            
            return
        }
        
        self.searchController.searchBar.removeFromSuperview()
        UIView.animate(withDuration: 0.5, animations: {
            self.searchViewHeight.constant = 0
            self.view.layoutIfNeeded()
        })
    }
}
