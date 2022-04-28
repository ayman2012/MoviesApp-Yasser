//
//  TrendingAPI.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 28/04/2022.
//

import Foundation
import Alamofire

enum TrendingAPI {
    case getMovies(page: Int)
}

extension TrendingAPI: RequestBuilder {
    var path: String {
        switch self {
        case .getMovies:
            return "discover/movie"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getMovies:
            return .get
        }
    }

    var parameters: [String: Any]? {
        var parameters = ["api_key": APIConstants.APIKay,
                          "format": "json"]
        switch self {
        case .getMovies(let page):
            parameters["sort_by"] = "popularity.desc"
            parameters["page"] = page.description
            return parameters
        }
    }
}
