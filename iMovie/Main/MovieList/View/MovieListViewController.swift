//
//  MovieListViewController.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit
import Foundation

protocol MovieListDisplaying: AnyObject {
    func showLoading(_ isLoading: Bool)
    func showError(with error: NetworkError)
    func fillMovieList(with movies: [Movie])
}

final class MovieListViewController: UIViewController {
    private let viewModel: MovieListViewModeling
    private var movieListView = MovieListView()
    
    private var movies: [Movie] = [] {
        didSet {
            movieListView.reloadTableView()
        }
    }
    
    init(viewModel: MovieListViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .main)
        
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(movieListView)
        movieListView.fillSuperviewToSafeArea()
        
        self.viewModel.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getMovieList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getMovieList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMovie = movies[indexPath.row]
        let cell: MovieListCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configureCell(with: currentMovie)
        return cell
    }
}

extension MovieListViewController: MovieListDisplaying {
    func showLoading(_ isLoading: Bool) {
        
    }
    
    func showError(with error: NetworkError) {
        
    }
    
    func fillMovieList(with movies: [Movie]) {
        self.movies = movies
    }
}
