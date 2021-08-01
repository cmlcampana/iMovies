//
//  MovieDetailViewModel.swift
//  iMovie
//
//  Created by Camila Campana on 23/02/21.
//
import Foundation

protocol MovieDetailViewModeling: AnyObject {
    var viewController: MovieDetailDisplaying? { get set }
    
    func loadMovieInfo()
 }

final class MovieDetailViewModel {
    weak var viewController: MovieDetailDisplaying?
    private let coordinator: MovieDetailCoordinating
    private let movie: Movie

    init(coordinator: MovieDetailCoordinating, movie: Movie) {
        self.coordinator = coordinator
        self.movie = movie
    }
}

extension MovieDetailViewModel: MovieDetailViewModeling {
    func loadMovieInfo() {
        viewController?.fillMovieInfo(movie)
    }
}
