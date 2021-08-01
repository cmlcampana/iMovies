//
//  MovieListViewModel.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

protocol MovieListViewModeling: AnyObject {
    var viewController: MovieListDisplaying? { get set }
    var currentPage: Int { get set }
    
    func getMovieList()
    func loadMoreMovies()
    func openMovieDetail(movie: Movie)
}

final class MovieListViewModel {
    weak var viewController: MovieListDisplaying?
    var currentPage = 0
    
    private let coordinator: MovieListCoordinating
    private let service: MovieListApi
    private var numberOfPages = 0
    
    init(coordinator: MovieListCoordinating, service: MovieListApi) {
        self.coordinator = coordinator
        self.service = service
    }
}

extension MovieListViewModel: MovieListViewModeling {
    func getMovieList() {
        viewController?.showLoading(true)
        getMovies()
    }
    
    func loadMoreMovies() {
        if currentPage <= numberOfPages {
            getMovies()
        }
    }
    
    func openMovieDetail(movie: Movie) {
        coordinator.navigateToDetail(detail: movie)
    }
    
    private func getMovies() {
        currentPage += 1
        service.getMovieList(page: currentPage) { [weak self] result in
            self?.viewController?.showLoading(false)
            switch result {
            case .success(let movieResult):
                self?.currentPage = movieResult.page
                self?.numberOfPages = movieResult.numberOfPages
                self?.viewController?.fillMovieList(with: movieResult.movies)
            case .failure(let error):
                self?.viewController?.showError(with: error)
            }
        }
    }
}
