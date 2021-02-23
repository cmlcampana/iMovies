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

    init(coordinator: MovieDetailCoordinating) {
        self.coordinator = coordinator
    }

    private let coordinator: MovieDetailCoordinating
}

extension MovieDetailViewModel: MovieDetailViewModeling { 
    weak var viewController: MovieDetailDisplaying?
}