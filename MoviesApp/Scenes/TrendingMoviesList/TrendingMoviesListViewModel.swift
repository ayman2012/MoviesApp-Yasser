//
//  TrendingMoviesListViewModel.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 27/04/2022.
//

import Foundation

protocol TrendingMoviesListViewModelProtocol {
    var reloadCallBack: (() -> Void)? { get set }
    var errorCallBack: ((Error?) -> Void)? { get set }
    var showLoadingCallBack: ((Bool) -> Void)? { get set }
    func getTrendingMoviesList(oldResult: Bool)
    func getNumberOfItems() -> Int
    func getMovie(for index: Int) -> MovieItem?
    func prefetchItemsAt(indexPaths: [IndexPath])
    func showMovieDetails(for movieIndex: Int)
}

class TrendingMoviesListViewModel: TrendingMoviesListViewModelProtocol {

    // MARK: - Properties
    var reloadCallBack: (() -> Void)?
    var errorCallBack: ((Error?) -> Void)?
    var showLoadingCallBack: ((Bool) -> Void)?

    private var moviesList: [MovieItem] = []
    private let page = Page()
    private let trendingAPI: NetworkManagerProtocol

    // MARK: - Initialization
    init(trendingAPI: NetworkManagerProtocol = NetworkManager()) {
        self.trendingAPI = trendingAPI
    }

    // MARK: - API Call
    func getTrendingMoviesList(oldResult: Bool) {
        guard page.shouldLoadMore else { return }

        showLoadingCallBack?(true)

        trendingAPI.sendRequest(endPoint: TrendingAPI.getMovies(page: page.currentPage),
                              decodingType: TrendingMoviesResponseModel.self) { [weak self] response in

            guard let self = self else { return }
            self.showLoadingCallBack?(false)

            switch response {
            case .success(let model):
                self.handlePaginationLogic(oldResult: oldResult, moviesListResponse: model)
                self.errorCallBack?(nil)
            case .failure(let error):
                self.errorCallBack?(error)
            }
        }
    }

    // MARK: - Helper Methods
    func getNumberOfItems() -> Int {
        return moviesList.count
    }

    func getMovie(for index: Int) -> MovieItem? {
        return moviesList[safe: index]
    }

    func showMovieDetails(for movieIndex: Int) {
        guard let movieId = moviesList[safe: movieIndex]?.id else { return }
        try? AppNavigator().push(.movieDetails(movieId))
    }
}

// MARK: Pagination Extension
extension TrendingMoviesListViewModel {

    func prefetchItemsAt(indexPaths: [IndexPath]) {
        guard let max = indexPaths.map({ $0.row }).max() else { return }
        if page.currentPage * page.countPerPage <= (max + 1) {
            getTrendingMoviesList(oldResult: false)
            page.currentPage += 1
        }
    }

    private func handlePaginationLogic(oldResult: Bool, moviesListResponse: TrendingMoviesResponseModel?) {
        guard let response = moviesListResponse,
              let moviesList = response.results else { return }
        page.maxPages = (response.totalResults ?? 0) / page.countPerPage

        if oldResult {
            page.maxPages == 0 ? page.reset() : ()
            self.moviesList = moviesList
            self.reloadCallBack?()
        } else {
            self.moviesList.append(contentsOf: moviesList)
            self.reloadCallBack?()
        }
    }
}
