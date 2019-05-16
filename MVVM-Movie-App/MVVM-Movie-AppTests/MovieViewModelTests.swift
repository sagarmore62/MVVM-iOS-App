//
//  MovieViewModelTests.swift
//  MVVM-Movie-AppTests
//
//  Created by Sagar More on 16/05/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import XCTest
@testable import MVVM_Movie_App

// MARK: - Class test movie view model
class MovieViewModelTests: XCTestCase {

    var vm : MovieViewModel!
    
    override func setUp() {
        vm = MovieViewModel()
        vm.transform(mockMovieList())
    }
    
    /// Method tests total movie count
    func testGetListCountMethod() {
        XCTAssert(vm.getListCount() == 10, "getListCount method failed")
    }
    
    /// Method tests total movie count after searching
    func testWithValidMovies() {
        let result = vm.getSearchedMovies("test")
        XCTAssert(result.count == 10, "valid movie search failed")
    }
    
    /// Method tests total movie count after searching
    func testWithInvalidMovies() {
        let result = vm.getSearchedMovies("random")
        XCTAssert(result.count == 0, "valid movie search failed")
    }
    
    /// Method tests error message for favourite screen
    func testPageErrorForFavourite() {
        XCTAssert(vm.getErrorMessage(true) == Constants.ErrorMessage.noFavouriteFound, "page error failed")
    }
    
    /// Method tests error for movies screen
    func testPageErrorForMovies() {
        XCTAssert(vm.getErrorMessage(false) == Constants.ErrorMessage.noResultFound, "page error failed")
    }
    
    /// Method tests paging
    func testValidPagingEnabled() {
        XCTAssert(vm.isShowNextMoviePage(4), "test valid paging enabled failed")
    }
    
    /// Method tests paging
    func testInValidPagingEnabled() {
        XCTAssert(!vm.isShowNextMoviePage(8), "test invalid paging enabled failed")
    }
    
    /// Method tests paging while searching movies
    func testDisablePagingInSearch() {
        vm.updatedSearchedMovies("test")
        XCTAssert(!vm.isShowNextMoviePage(4), "test disable paging in search failed.")
    }
}

// MARK: - mock data methods
extension MovieViewModelTests {
    
    private func mockMovieList() ->MovieList {
        let model = MovieList.init(results: getMovieObjectArray(10), page: 1, totalPages: 10)
        return model
    }
    
    private func getMovieObjectArray(_ count : Int) -> [MovieObject] {
        var arr = [MovieObject]()
        for _ in 1...count {
            arr.append(MovieObjectViewModelTests.mockMovieObjectModel())
        }
        return arr
    }
}
