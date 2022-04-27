//
//  NetworkFailure.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 27/04/2022.
//

import Foundation

enum NetworkFailure: LocalizedError {
    case generalFailure, failedToParseData, connectionFailed
    var errorDescription: String? {
        switch self {
        case .failedToParseData:
            return "Technical Difficulties, we can't fetch the data"
        default:
            return "Check your connectivity"
        }
    }
}
