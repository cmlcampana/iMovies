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

    private var movie: Movie?
    
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
        
        let share = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItem = share
        
        view.backgroundColor = UIColor(red: 224/255, green: 193/255, blue: 247/255, alpha: 1)
        view.addSubview(movieDetailView)
        movieDetailView.fillSuperviewToSafeArea()
        
        viewModel.loadMovieInfo()
    }
    
    @objc private func shareTapped() {
        guard let movie = movie else { return }
        let messageSharing =
            """
                See that movie! \n
                Title: \(movie.title)\n
                Release date: \(movie.releaseDate?.formatDate() ?? "Soon")\n
                Rating: \(movie.rating)
            """
        let activityViewController = UIActivityViewController(activityItems: [messageSharing],
                                                              applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}

extension MovieDetailViewController: MovieDetailDisplaying {
    func fillMovieInfo(_ movie: Movie) {
        self.movie = movie
        movieDetailView.configureView(with: movie)
    }
}
