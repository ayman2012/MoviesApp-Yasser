//
//  Destination.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 28/04/2022.
//

import Foundation
import UIKit
enum Destination {
    case moviesList
    case movieDetails(Int)

    func controller() -> UIViewController {
        switch self {
        case .moviesList:
            return getMoviesList()

        case let .movieDetails(movieId):
            return getMovieDetails(for: movieId)
        }
    }
}

extension Destination {
    private func getMoviesList() -> UIViewController {
        let viewModel = TrendingMoviesListViewModel()
        let trendingVC = TrendingMoviesListViewController.init(with: viewModel)
        return trendingVC
    }

    private func getMovieDetails(for movieId: Int) -> UIViewController {
        let viewModel = MovieDetailsViewModel.init(movieId: movieId)
        let movieDetailsVC = MovieDetailsViewController(with: viewModel)
        return movieDetailsVC
    }
}
