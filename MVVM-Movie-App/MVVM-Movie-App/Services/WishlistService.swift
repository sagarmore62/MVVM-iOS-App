//
//  WishlistService.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 14/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

class WishlistService {
    static let shared = WishlistService()
    private var moviesViewModel = [MovieObjectViewModel]()
    private var movieIDs = Set<Int>()
    
    private init() {
    }
    
    func getFavouriteMovies() -> [MovieObjectViewModel] {
        return moviesViewModel
    }
    
    private func addToWishlist(_ movie : MovieObjectViewModel) {
        moviesViewModel.append(movie)
        movieIDs.insert(movie.movieId)
    }
    
    private func removeFromWishlist(_ movie : MovieObjectViewModel) {
        let index = moviesViewModel.firstIndex { (mov) -> Bool in
            return mov.movieId == movie.movieId
        }
        guard let ind = index else { return }
        moviesViewModel.remove(at: ind)
        movieIDs.remove(movie.movieId)
    }
    
    func isWishlistedMovie(_ movie : MovieObjectViewModel) -> Bool {
        return movieIDs.contains(movie.movieId)
    }
    
    @discardableResult
    func toggleWishlist(_ movie : MovieObjectViewModel) -> Bool {
        let isWishlisted = isWishlistedMovie(movie)
        if isWishlisted {
            removeFromWishlist(movie)
        } else {
            addToWishlist(movie)
        }
        return isWishlisted
    }
    
}
