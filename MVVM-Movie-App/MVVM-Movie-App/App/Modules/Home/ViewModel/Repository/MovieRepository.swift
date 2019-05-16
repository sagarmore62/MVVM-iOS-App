//
//  MovieRepository.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 13/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

/// Repository to feed data for movie model
struct MovieRepository {
    
    /// method makes network call for movies result
    ///
    /// - Parameters:
    ///   - pageNo: page number 
    ///   - completionHandler: handler for data and error
    func getMovies( pageNo : Int, completionHandler : @escaping (Data?, Error?) -> Void) {
        let url = EndPoint.popularMovies + EndPoint.pagePath + pageNo.description + EndPoint.andPath
        NetworkService.shared.startRequest(url, httpMethod: .get) { (data, err) in
            completionHandler(data, err)
        }
    }
}
