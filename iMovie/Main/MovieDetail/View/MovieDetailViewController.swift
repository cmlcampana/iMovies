//
//  MovieDetailViewController.swift
//  iMovie
//
//  Created by Camila Campana on 23/02/21.
//
import UIKit

protocol MovieDetailDisplaying: AnyObject {
    func fillMovieInfo(_ movie: Movie)
}

final class MovieDetailViewController: UIViewController {
    private var movieDetailView = MovieDetailView()
    private let viewModel: MovieDetailViewModeling

    init(with viewModel: MovieDetailViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.viewController = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(movieDetailView)
        movieDetailView.fillSuperviewToSafeArea()
        
        viewModel.loadMovieInfo()
    }
}

extension MovieDetailViewController: MovieDetailDisplaying {
    func fillMovieInfo(_ movie: Movie) {
        movieDetailView.configureView(with: movie)
    }
}
