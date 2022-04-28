//
//  MovieDetailsApi.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 28/04/2022.
//

import Foundation
import Alamofire

enum MovieDetailsApi {
    case getMovieDetails(movieId: Int)
}

extension MovieDetailsApi: RequestBuilder {
    var path: String {
        switch self {
        case let .getMovieDetails(movieId):
            return "movie/\(movieId)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getMovieDetails:
            return .get
        }
    }

    var parameters: [String: Any]? {
        let parameters = ["api_key": APIConstants.APIKay,
                          "format": "json"]
        switch self {
        case .getMovieDetails:
            return parameters
        }
    }
}

