//
//  Pageable.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 28/04/2022.
//

import Foundation

//protocol Pageable {
//    func loadCells(for indexPaths: [IndexPath])
//}

final class Page {
    var currentPage = 1
    var maxPages = 5
    var countPerPage = 20
    var shouldLoadMore: Bool {
        (currentPage <= maxPages)
    }

    func reset() {
        currentPage = 1
        maxPages = 5
    }
}
