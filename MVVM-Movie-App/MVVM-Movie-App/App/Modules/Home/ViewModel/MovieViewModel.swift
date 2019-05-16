//
//  MovieViewModel.swift
//  MVVM-Movie-App
//
//  Created by Sagar More on 13/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

protocol MovieViewModelProtocol : class {
    func movieListUpdated()
    func apiErrorUpdated(_ error : Error?)
    func onWishlistUpdate(_ indexPath : IndexPath)
    func emptyResult()
}

class MovieViewModel {
    
    /// Contains initial movie list of popular movies
    private var list = [MovieObjectViewModel]() {
        didSet {
            searchedList = list
        }
    }
    
    /// Contains filtered list of movies
    private var searchedList = [MovieObjectViewModel]() {
        didSet {
            delegate?.movieListUpdated()
            if searchedList.isEmpty {
                delegate?.emptyResult()
            }
        }
    }
    private var error : Error? {
        didSet {
            delegate?.apiErrorUpdated(error)
        }
    }
    private let repo : MovieRepository
    weak var delegate : MovieViewModelProtocol?
    private var isPagingEnabled = true
    private var currentPageNo = 1
    private var totalPages = 0
    private var isSearching = false
    var searchText : String? {
        didSet {
            currentPageNo = 1
            totalPages = 1
            updatedSearchedMovies(searchText)
        }
    }
    
    init() {
        repo = MovieRepository()
    }
    
    /// Method hits api and updates the view model from result
    ///
    /// - Parameter isFavourite: movies for favourite screen or not
    func getMovies(_ isFavourite : Bool) {
        if isFavourite {
            getFavourites()
        } else {
            getPopularMovies()
        }
    }
    
    private func getPopularMovies() {
        repo.getMovies(pageNo: currentPageNo, completionHandler: { [unowned self] (data, err) in
            if let newData = data {
                newData.getJsonModel(modelType: MovieList.self, completionHandler: { (model, error) in
                    if let unwrapped = model {
                        if self.currentPageNo == 1 {
                            self.transform(unwrapped)
                        } else {
                            self.appendNewMovies(unwrapped)
                        }
                    } else {
                        self.error = error
                    }
                })
            } else {
                self.error = err
            }
        })
    }
    
    /// Method filters movie list by search text
    ///
    /// - Parameter searchText: search text
    func updatedSearchedMovies(_ searchText : String?) {
        searchedList = getSearchedMovies(searchText)
    }
    
    /// Method filters the existing movies list by search text
    ///
    /// - Parameter searchText: text for movies to search
    /// - Returns: list of filtered movies
    func getSearchedMovies(_ searchText : String?) -> [MovieObjectViewModel] {
        var newList = [MovieObjectViewModel]()
        guard let text = searchText?.lowercased(), !text.isEmpty else {
            newList = list
            isSearching = false
            return newList
        }
        //filters case-insensitive search text
        isSearching = true
        newList = list.filter({ $0.description.string.lowercased().contains(text) })
        return newList
    }
    
    /// Method transforms model to view model
    /// - Parameter model: MovieList model
    func transform(_ model : MovieList) {
        let arr = model.results.map({ MovieObjectViewModel($0)})
        list = arr
        totalPages = model.totalPages ?? 0
    }
    
    /// Appends new movies to existing list
    ///
    /// - Parameter model: movie list model
    private func appendNewMovies(_ model : MovieList) {
        let arr = model.results.map({ MovieObjectViewModel($0)})
        list.append(contentsOf: arr)
        
    }
    
    /// Method return number of movies
    ///
    /// - Returns: Number of movies
    func getListCount() -> Int {
        return searchedList.count
    }
    
    /// Method returns view model for for row at index
    ///
    /// - Parameter index: Index of view model
    /// - Returns: view model of moview
    func getCellDataWith(_ index : Int) -> MovieObjectViewModel {
        return searchedList[index]
    }
    
}

// MARK: - favourite screen methods
extension MovieViewModel {
    func wishlistUpdateWith(_ index : IndexPath, isFavourite : Bool) {
        let isRemoved = WishlistService.shared.toggleWishlist(searchedList[index.row])
        if isFavourite && isRemoved {
            //If wishlist action is from favourite screen & action is removed, get updated list
            getFavourites()
        } else {
            delegate?.onWishlistUpdate(index)
        }
    }
    
    private func getFavourites() {
        searchedList = WishlistService.shared.getFavouriteMovies()
    }
    
    /// Method returns error screen message
    ///
    /// - Parameter isFavourite: Boolean indicates error message requires for favourite screen or not
    /// - Returns: Error message in String
    func getErrorMessage (_ isFavourite : Bool) -> String {
        return isFavourite ? Constants.ErrorMessage.noFavouriteFound : Constants.ErrorMessage.noResultFound
    }
}

// MARK: - Pagination methods
extension MovieViewModel {
    /// Gets new page data for movies
    ///
    /// - Parameter indexPath : index path of collection view
    func getNextPageData(_ cellRow : Int) {
        if isShowNextMoviePage(cellRow) {
            currentPageNo += 1
            getPopularMovies()
        }
    }
    
    /// Method tells whether next page in pagination exist
    ///
    /// - Parameter cellRow: current cell row index in Int
    /// - Returns: Boolean tells next page existance status
    func isShowNextMoviePage(_ cellRow : Int) -> Bool {
        //while searching paging is disabled
        guard isPagingEnabled, !isSearching else {
            return false
        }
        if totalPages > currentPageNo {
            //next page api hits on 6th last cell in collection view.
            if cellRow == (list.count - 6) {
                return true
            }
        } else {
            isPagingEnabled = false
        }
        return false
    }
}


