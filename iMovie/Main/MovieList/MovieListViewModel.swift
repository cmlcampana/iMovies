//
//  MovieListViewModel.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

protocol MovieListViewModeling: AnyObject {
    var viewController: MovieListDisplaying? { get set }
    func getMovieList()
    func openMovieDetail(movie: Movie)
}

final class MovieListViewModel {
    weak var viewController: MovieListDisplaying?
    private let coordinator: MovieListCoordinating
    private let service: MovieListApi
    
    init(coordinator: MovieListCoordinating, service: MovieListApi) {
        self.coordinator = coordinator
        self.service = service
    }
}

extension MovieListViewModel: MovieListViewModeling {
    func getMovieList() {
        viewController?.showLoading(true)
        
        service.getMovieList { [weak self] result in
            self?.viewController?.showLoading(false)
            switch result {
            case .success(let movieResult):
                self?.viewController?.fillMovieList(with: movieResult.movies)
            case .failure(let error):
                self?.viewController?.showError(with: error)
            }
        }
    }
    
    func openMovieDetail(movie: Movie) {
        coordinator.navigateToDetail(detail: movie)
    }
}
