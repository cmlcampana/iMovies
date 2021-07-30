//
//  MovieDetailFactory.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit
import Foundation

struct MovieDetailFactory {
    static func make(navigationController: UINavigationController, movie: Movie) -> MovieDetailViewController {
        let coordinator = MovieDetailCoordinator(navigationController: navigationController)
        let viewModel = MovieDetailViewModel(coordinator: coordinator, movie: movie)
        let viewController = MovieDetailViewController(with: viewModel)
        
        return viewController
    }
}
