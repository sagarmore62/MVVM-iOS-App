//
//  EndPoint.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 13/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

// MARK: - API end points constant
struct EndPoint {
    static let searchMovies = "/search/movie?"
    static let popularMovies = "/movie/popular?"
    static let domainImage  = "https://image.tmdb.org/t/p/"
    static let apiKey       = "88c3c89ea75c320742f2d7f94e5dbd39"
    static let keyPath      = "api_key="
    static let queryPath    = "&query="
    static let pagePath     = "&page="
    static let andPath      = "&"
    static let baseUrl      = "https://api.themoviedb.org/3"
}
