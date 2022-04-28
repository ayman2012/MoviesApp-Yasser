//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 28/04/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var movieDateLabel: UILabel!
    @IBOutlet private var movieDescriptionLabel: UILabel!
    @IBOutlet private var movieImageView: UIImageView!
    
    //MARK:- Properties
    private var viewModel: MovieDetailsViewModelProtocol

    //MARK:- Initialization
    init(with viewModel: MovieDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCallBacks()
        viewModel.getMovieDetails()
    }
    
    //MARK:- Utilities
    private func setupCallBacks() {
        viewModel.reloadCallBack = { [weak self] movieDetailsModel in
            self?.updateUI(with: movieDetailsModel)
        }
    }
    
    private func updateUI(with dataModel: MovieDetailsUIModel) {
        movieTitleLabel.text = dataModel.title
        movieDateLabel.text = dataModel.releaseDate
        movieDescriptionLabel.text = dataModel.description
        movieImageView.loadImage(with: APIConstants.imageURL.appending(dataModel.imageURL))
    }
}
