//
//  MovieDetailViewController.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 07/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet var backdropImageView: UIImageView!
    @IBOutlet var bannerImageView: UIImageView!
    @IBOutlet var movieNameLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    // MARK: - Model Object
    var movie: MovieModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
    }
    
    // MARK: - Methods
    func setData() {
        backdropImageView.image = UIImage(data: movie?.backDropImage ?? Data())
        bannerImageView.image = UIImage(data: movie?.posterImage ?? Data())
        
        movieNameLabel.text = movie?.title
        
        setReleaseDate()
        
        ratingLabel.text = "Rating: \(movie?.vote_average ?? 0)"
        overviewLabel.text = movie?.overview
    }
    
    fileprivate func setReleaseDate() {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        if let date = dateFormatterGet.date(from: movie?.release_date ?? "") {
            releaseDateLabel.text = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
    }
}
