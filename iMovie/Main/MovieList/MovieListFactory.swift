//
//  MovieListFactory.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit
import Foundation

struct MovieListFactory {
    static func make() -> MovieListViewController {
        let coordinator = MovieListCoordinator()
        let service = MovieListService(service: NetworkManager())
        let viewModel = MovieListViewModel(coordinator: coordinator, service: service)
        let viewController = MovieListViewController(viewModel: viewModel)
        return viewController
    }
}
