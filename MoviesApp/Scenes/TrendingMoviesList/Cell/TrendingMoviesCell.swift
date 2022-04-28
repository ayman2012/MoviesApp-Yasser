//
//  TrendingMoviesCell.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 27/04/2022.
//

import UIKit

class TrendingMoviesCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var movieDateLabel: UILabel!
    @IBOutlet private var movieImageView: UIImageView!

    //MARK- Static Properties
    static var identifier: String {
        return String.init(describing: self)
    }
    
    static var nib: UINib {
        return UINib.init(nibName: String.init(describing: self), bundle: nil)
    }
    
    //MARK:- Utilities Methods
    /// Setup cell with data
    /// - Parameter dataModel: The response model from the API
    func setupCell(with dataModel: MovieItem?) {
        movieTitleLabel.text = dataModel?.title ?? "- -"
        movieDateLabel.text = dataModel?.releaseDate ?? "- -"
        guard let imagePath = dataModel?.posterPath else { return }
        movieImageView.loadImage(with: APIConstants.imageURL.appending(imagePath))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitleLabel.text = "- -"
        movieDateLabel.text = "- -"
        movieImageView.image = nil
    }
}
