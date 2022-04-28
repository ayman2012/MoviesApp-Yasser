//
//  TrendingMoviesListViewModel.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 27/04/2022.
//

import Foundation

protocol TrendingMoviesListViewModelProtocol {
    var reloadCallBack: (() -> ())? { get set }
    var errorCallBack: ((Error) -> ())? { get set }
    var showLoadingCallBack: ((Bool) -> ())? { get set }
    func getTrendingMoviesList(newResult: Bool) -> Void
    func getNumberOfItems() -> Int
    func getMovie(for index: Int) -> MovieItem?
    func prefetchItemsAt(indexPaths: [IndexPath])
}

class TrendingMoviesListViewModel: TrendingMoviesListViewModelProtocol {
    
    //MARK:- Properties
    var reloadCallBack: (() -> ())?
    var errorCallBack: ((Error) -> ())?
    var showLoadingCallBack: ((Bool) -> ())?
    
    private var moviesList: [MovieItem] = []
    private let page = Page()
    private let artistApi: NetworkManagerProtocol
    
    //MARK:- Initialization
    init(artistApi: NetworkManagerProtocol = NetworkManager()) {
        self.artistApi = artistApi
    }
    
    //MARK:- API Call
    func getTrendingMoviesList(newResult: Bool) {
        guard page.shouldLoadMore else { return }
        
        showLoadingCallBack?(true)
        
        artistApi.sendRequest(endPoint: ArtistApi.getMovies(page: page.currentPage),
                              decodingType: TrendingMoviesResponseModel.self) { [weak self] response in
            
            guard let self = self else { return }
            self.showLoadingCallBack?(false)
    
            switch response {
            case .success(let model):
                self.handlePaginationLogic(newResult: newResult, moviesListResponse: model)
            case .failure(let error):
                self.errorCallBack?(error)
            }
        }
    }
    
    //MARK:- Helper Methods
    func getNumberOfItems() -> Int {
        return moviesList.count
    }
    
    func getMovie(for index: Int) -> MovieItem? {
        return moviesList[safe: index]
    }
}

// MARK: Pagination Extension
extension TrendingMoviesListViewModel {
    
    func prefetchItemsAt(indexPaths: [IndexPath]) {
        guard let max = indexPaths.map({ $0.row }).max() else { return }
        if page.currentPage * page.countPerPage <= (max + 1) {
            getTrendingMoviesList(newResult: true)
            page.currentPage += 1
        }
    }
    
    private func handlePaginationLogic(newResult: Bool, moviesListResponse: TrendingMoviesResponseModel?) {
        guard let response = moviesListResponse,
              let moviesList = response.results else { return }
        page.maxPages = (response.totalResults ?? 0) / page.countPerPage
        
        if newResult {
            page.maxPages == 0 ? page.reset() : ()
            self.moviesList = moviesList
            self.reloadCallBack?()
        } else {
            self.moviesList.append(contentsOf: moviesList)
            self.reloadCallBack?()
        }
    }
}
