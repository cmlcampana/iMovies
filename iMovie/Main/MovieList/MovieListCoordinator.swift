//
//  MovieListCoordinator.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit
import Foundation

protocol MovieListCoordinating: AnyObject {
    func navigateToDetail(detail: Movie)
}

final class MovieListCoordinator: Coordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension MovieListCoordinator: MovieListCoordinating {
    func navigateToDetail(detail: Movie) {
        let viewController = MovieDetailFactory.make(navigationController: navigationController, movie: detail)
        navigationController.pushViewController(viewController, animated: true)
    }
}
