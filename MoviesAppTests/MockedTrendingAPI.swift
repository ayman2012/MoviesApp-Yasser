//
//  MockedTrendingAPI.swift
//  MoviesAppTests
//
//  Created by Ayman Fathy on 28/04/2022.
//

import Foundation
@testable import MoviesApp

class MockedTrendingAPI: NetworkManagerProtocol {
  
    
    func sendRequest<ResponseType>(endPoint: RequestBuilder,
                                   decodingType: ResponseType.Type,
                                   completion: @escaping (Result<ResponseType, Error>) -> Void) where ResponseType : Decodable {
        guard let data = TestHelper().loadStubDataFromBundle(name: "TrendingMoviesListMockedJson", extension: "json"),
              let model: ResponseType =  try? JSONDecoder().decode(decodingType.self, from: data) else {
                  completion(.failure(NetworkFailure.generalFailure))
                  return
        }
        completion(.success(model))
    }
}
