//
//  MovieCollectionViewCell.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 06/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet weak var movieImageView: UIImageView?
    @IBOutlet weak var movieDescriptionLabel: UILabel?
    
    // MARK: - Model Object
    var movie: MovieModel? {
        didSet {
            configureCell()
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieDescriptionLabel?.text = nil
        movieImageView?.image = nil
    }
    
    // MARK: - Methods
    func configureCell() {
        movieDescriptionLabel?.text = movie?.title
        
        if let movieImage = movie?.posterImage {
            movieImageView?.image = UIImage(data: movieImage)

            return
        }
        
        ImageRepository.downloadMovieImage(movieId: movie?.id, imagePath: movie?.poster_path, imageSize: .w200, isBackDrop: false, success: { (imageData) in
            self.movieImageView?.image = UIImage(data: imageData)
            self.movie?.posterImage = imageData
        }) { (error) in
            print(error)
        }
        
        ImageRepository.downloadMovieImage(movieId: movie?.id, imagePath: movie?.backdrop_path, imageSize: .w300, isBackDrop: true, success: { (imageData) in
            self.movie?.backDropImage = imageData
        }) { (error) in
            print(error)
        }
    }
}
