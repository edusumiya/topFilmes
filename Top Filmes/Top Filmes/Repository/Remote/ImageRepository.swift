//
//  ImageRepository.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 07/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation
import Alamofire

class ImageRepository: NSObject {
    // MARK: - TypeAlias
    typealias SuccessImage = (_ image: Data) -> Void
    typealias Failure = (_ error: Error) -> Void
    
    // MARK: - Blocks
    fileprivate var successImage: (SuccessImage)?
    fileprivate var failure: (Failure)?
    
    /// Requests the Image Data by URL
    ///
    /// - Parameters:
    ///   - imagePath: image Path
    ///   - imageSize: Size of Image
    ///   - success: success block
    ///   - failure: failure block
    static func downloadMovieImage(movieId: Int?, imagePath: String?, imageSize: ImageSizeEnum, isBackDrop: Bool, success: @escaping SuccessImage, failure: @escaping Failure) {
        var imageUrl: String = ""
        
        switch imageSize {
        case .w200:
            imageUrl = ApiConstants.image200Url
        case .w300:
            imageUrl = ApiConstants.image300Url
        case .original:
            imageUrl = ApiConstants.imageOriginalUrl
        }
        
        let url = "\(imageUrl)\(imagePath ?? "")"
        
        Alamofire.request(url).response { (response) in
            if let data = response.data {
                CoreDataRepository.updateMovieImage(movieId: movieId ?? 0, movieImageData: data, isBackDrop: isBackDrop)
                
                success(data)
                return
            }
            
            failure(NSError(domain: "Failed to download image", code: 404, userInfo: nil))
        }
    }
}
