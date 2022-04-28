//
//  TrendingMoviesListViewController.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 27/04/2022.
//

import UIKit

class TrendingMoviesListViewController: UIViewController, Loadable {
    
    //MARK:- Outlets
    @IBOutlet private var moviesTableView: UITableView!

    
    //MARK:- Properties
    private var viewModel: TrendingMoviesListViewModelProtocol

    //MARK:- Initialization
    init(with viewModel: TrendingMoviesListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies List"
        registerTableViewCell()
        setupTableView()
        setupCallBacks()
        
        viewModel.getTrendingMoviesList(newResult: false)
    }
    
    //MARK:- Utilities
    private func registerTableViewCell() {
        moviesTableView.register(TrendingMoviesCell.nib, forCellReuseIdentifier: TrendingMoviesCell.identifier)
    }
    
    private func setupTableView() {
        moviesTableView.separatorStyle = .none
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.prefetchDataSource = self
    }
    
    private func setupCallBacks() {
        viewModel.reloadCallBack = { [weak self] in
            DispatchQueue.main.async {
                self?.moviesTableView.reloadData()
            }
        }
        
        viewModel.showLoadingCallBack = { [weak self] isShowLoading in
            self?.showLoading(show: isShowLoading)
        }
    }
}

extension TrendingMoviesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showMovieDetails(for: indexPath.row)
    }
}

extension TrendingMoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: TrendingMoviesCell.identifier, for: indexPath) as? TrendingMoviesCell else { return UITableViewCell() }
        let dataModel = viewModel.getMovie(for: indexPath.row)
        cell.setupCell(with: dataModel)
        return cell
    }
}

extension TrendingMoviesListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.prefetchItemsAt(indexPaths: indexPaths)
    }
}
