//
//  MovieDetailViewModelTests.swift
//  iMovieTests
//
//  Created by Camila Campana on 01/08/21.
//

import XCTest
@testable import iMovie

private final class MovieDetailCoordinatorSpy : MovieDetailCoordinating { }

private final class MovieDetailViewControllerSpy: MovieDetailDisplaying {
    private(set) var fillMovieInfoCallsCount = 0
    private(set) var movieReceived: Movie?
    
    func fillMovieInfo(_ movie: Movie) {
        fillMovieInfoCallsCount += 1
        movieReceived = movie
    }
}

final class MovieDetailViewModelTests: XCTestCase {
    private let coordinatorSpy = MovieDetailCoordinatorSpy()
    private let viewControllerSpy = MovieDetailViewControllerSpy()
    private let movieMock = iMoviesSeeds.MovieSeed.movieDetail()
    
    private lazy var sut: MovieDetailViewModeling = {
        let viewModel = MovieDetailViewModel(coordinator: coordinatorSpy, movie: movieMock)
        viewModel.viewController = viewControllerSpy
        return viewModel
    }()
    
    func testLoadMovieInfo_ShouldCallViewControllerWithMovieDetail() {
        let movieExpected = iMoviesSeeds.MovieSeed.movieDetail()
        
        sut.loadMovieInfo()
        
        XCTAssertEqual(viewControllerSpy.fillMovieInfoCallsCount, 1)
        XCTAssertEqual(viewControllerSpy.movieReceived, movieExpected)
    }
}
