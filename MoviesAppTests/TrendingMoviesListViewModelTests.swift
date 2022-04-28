//
//  TrendingMoviesListViewModelTests.swift
//  MoviesAppTests
//
//  Created by Ayman Fathy on 28/04/2022.
//

import XCTest
@testable import MoviesApp

class TrendingMoviesListViewModelTests: XCTestCase {
    
    var viewModel: TrendingMoviesListViewModel!
    
    override func setUpWithError() throws {
        viewModel = TrendingMoviesListViewModel.init(trendingAPI: MockedTrendingAPI())
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_GetTrendingMoviesList() {
        
        // Given
        let loadDataExpectation = expectation(description: "Wait for loading more search result")
        viewModel.reloadCallBack = {
            loadDataExpectation.fulfill()
        }
        
        // When
        viewModel.getTrendingMoviesList(newResult: false)
        
        // Then
        
        waitForExpectations(timeout: 5) { (error) in
            if error != nil {
                XCTFail("Expectation not fulfilled")
            }
        }
        XCTAssertEqual(viewModel.getNumberOfItems(), 20)
        
    }
}
