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
            switch result {
            case .success(let movieResult):
                self?.viewController?.fillMovieList(with: movieResult.movies)
            case .failure(let error):
                self?.viewController?.showError(with: error)
            }
        }
    }
}
