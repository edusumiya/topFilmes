//
//  ApiRepository.swift
//  Top Filmes
//
//  Created by Eduardo Sumiya on 06/01/19.
//  Copyright © 2019 Eduardo Sumiya. All rights reserved.
//

import Foundation
import Alamofire

class TopMoviesRepository: NSObject {
    // MARK: - TypeAlias
    typealias SuccessMovies = (_ resultMovie: MovieResultModel) -> Void
    typealias Failure = (_ error: Error) -> Void
    
    // MARK: - Blocks
    fileprivate var successMovies: (SuccessMovies)?
    fileprivate var failure: (Failure)?
    
    /// Requests the Top Movies
    ///
    /// - Parameters:
    ///   - page: page of Api
    ///   - success: success block
    ///   - failure: failure block
    static func fetchTopMovies(page: Int, success: @escaping SuccessMovies, failure: @escaping Failure) {
        let url = "\(ApiConstants.apiUrl)\(ApiConstants.discoverEndpoint)"
        let params: [String:Any] = [ApiConstants.apiKeyParam : ApiConstants.apiKeyValue,
                                    ApiConstants.pageParam : page,
                                    ApiConstants.sortParam : ApiConstants.sortValue]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { response in
            if response.result.isSuccess {
                if let response = response.data {
                    do {
                        let moviesResult = try JSONDecoder().decode(MovieResultModel.self, from: response)
                        
                        success(moviesResult)
                    } catch let error {
                        failure(error)
                    }
                }
            } else {
                failure(response.result.error ?? NSError(domain: Localization.errorRetrieveDatabase.localized, code: 500, userInfo: nil))
            }
        }
    }
}
