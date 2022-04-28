//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 28/04/2022.
//

import Foundation

protocol MovieDetailsViewModelProtocol {
    var reloadCallBack: ((MovieDetailsUIModel) -> ())? { get set }
    var showLoadingCallBack: ((Bool) -> ())? { get set }
    var errorCallBack: ((Error?) -> ())? { get set }
    func getMovieDetails()
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    
    //MARK:- Properties
    private let movieDetailsApi: NetworkManagerProtocol
    private let movieId: Int
    var reloadCallBack: ((MovieDetailsUIModel) -> ())?
    var showLoadingCallBack: ((Bool) -> ())?
    var errorCallBack: ((Error?) -> ())?

    //MARK:- Initialization
    init(movieId: Int, movieDetailsApi: NetworkManagerProtocol = NetworkManager()) {
        self.movieId = movieId
        self.movieDetailsApi = movieDetailsApi
    }
    
    //MARK:- API Call
    func getMovieDetails() {
        showLoadingCallBack?(true)
        
        movieDetailsApi.sendRequest(endPoint: MovieDetailsApi.getMovieDetails(movieId: movieId),
                              decodingType: MovieDetailsResponseModel.self) { [weak self] response in
            
            guard let self = self else { return }
            self.showLoadingCallBack?(false)
    
            switch response {
            case .success(let model):
                let moviesDetailsUIModel = self.mapMovieDetailsResponseToUIModel(responseModel: model)
                self.reloadCallBack?(moviesDetailsUIModel)
                self.errorCallBack?(nil)
            case .failure(let error):
                self.errorCallBack?(error)
            }
        }
    }
    
    //MARK:- Helper Methods
    private func mapMovieDetailsResponseToUIModel(responseModel: MovieDetailsResponseModel) -> MovieDetailsUIModel {
        return .init(title: responseModel.title,
                     releaseDate: responseModel.releaseDate,
                     description: responseModel.overview,
                     imageURL: responseModel.posterPath)
    }
    
}
