//
//  MovieListFactory.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit
import Foundation

struct MovieListFactory {
    static func make(navigationController: UINavigationController) -> MovieListViewController {
        let coordinator = MovieListCoordinator(navigationController: navigationController)
        let service = MovieListService(service: NetworkManager())
        let viewModel = MovieListViewModel(coordinator: coordinator, service: service)
        let viewController = MovieListViewController(viewModel: viewModel)
        return viewController
    }
}
