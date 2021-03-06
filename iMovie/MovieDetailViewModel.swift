//
//  MovieDetailViewModel.swift
//  iMovie
//
//  Created by Camila Campana on 23/02/21.
//
import Foundation

protocol MovieDetailViewModeling: AnyObject {
    var viewController: MovieDetailDisplaying? { get set }
 }

final class MovieDetailViewModel {
    weak var viewController: MovieDetailDisplaying?

    init(coordinator: MovieDetailCoordinating) {
        self.coordinator = coordinator
    }

    private let coordinator: MovieDetailCoordinating
}

extension MovieDetailViewModel: MovieDetailViewModeling { }