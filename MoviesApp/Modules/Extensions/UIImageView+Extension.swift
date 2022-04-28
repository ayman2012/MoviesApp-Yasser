//
//  UIImageView+Extension.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 28/04/2022.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {

    func loadImage(with url: String) {
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                self.image = image
            }
        }
    }
}
