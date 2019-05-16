//
//  MovieObject.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 13/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

struct MovieObject : Decodable{
    let title          : String?
    let posterPath     : String?
    let voteAverage    : Float?
    let id             : Int
    let overview       : String?
    let releaseDate    : String?
}
