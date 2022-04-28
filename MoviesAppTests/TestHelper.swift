//
//  TestHelper.swift
//  MoviesAppTests
//
//  Created by Ayman Fathy on 28/04/2022.
//

import Foundation
class TestHelper {
    /**
     get data from static jsons
     - Parameter name: file name
     - Parameter extension: file extension
     */
    func loadStubDataFromBundle(name: String, extension: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: `extension`)
        guard let url = url else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
}
