//
//  MovieDetailCoordinator.swift
//  iMovie
//
//  Created by Camila Campana on 23/02/21.
//

import UIKit
import Foundation

protocol MovieDetailCoordinating: AnyObject { }

final class MovieDetailCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension MovieDetailCoordinator: MovieDetailCoordinating { }
