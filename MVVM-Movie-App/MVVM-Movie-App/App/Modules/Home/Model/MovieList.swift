//
//  MovieList.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 13/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

struct MovieList : Decodable {
    // list of movies in result
    var results        : [MovieObject]
    var page           : Int?
    var totalPages   : Int?
}


