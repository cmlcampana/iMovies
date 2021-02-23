//
//  MovieDetailCoordinator.swift
//  iMovie
//
//  Created by Camila Campana on 22/02/21.
//
import Foundation

protocol MovieDetailCoordinating: AnyObject { }

final class MovieDetailCoordinator {

    func start() {

    }

    private lazy var viewModel: MovieDetailViewModeling = {
        let vm = MovieDetailViewModel(coordinator: self)
        return vm
    }()

    private lazy var viewController: MovieDetailDisplaying = {
        let vc = MovieDetailViewController(with: viewModel)
        return vc
    }()
}

extension MovieDetailCoordinator: MovieDetailCoordinating { }