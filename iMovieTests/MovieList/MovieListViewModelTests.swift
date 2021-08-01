//
//  MovieListViewModelTests.swift
//  iMovieTests
//
//  Created by Camila Campana on 01/08/21.
//

import XCTest
@testable import iMovie

final class MovieListCoordinatorSpy: MovieListCoordinating {
    private(set) var navigateToDetailCallsCount = 0
    private(set) var detailReceived: Movie?
    
    func navigateToDetail(detail: Movie) {
        navigateToDetailCallsCount += 1
        detailReceived = detail
    }
}

final class MovieListViewControllerSpy: MovieListDisplaying {
    private(set) var showLoadingCallsCount = 0
    private(set) var showErrorCallsCount = 0
    private(set) var fillMovieListCallsCount = 0
    private(set) var errorReceived: NetworkError?
    private(set) var moviesReceived: [Movie]?
    
    func showLoading(_ isLoading: Bool) {
        showLoadingCallsCount += 1
    }
    
    func showError(with error: NetworkError) {
        showErrorCallsCount += 1
        errorReceived = error
    }
    
    func fillMovieList(with movies: [Movie]) {
        fillMovieListCallsCount += 1
        moviesReceived = movies
    }
}

final class MovieListServiceMock: MovieListApi {
    var isSuccess = true
    var result = iMoviesSeeds.MovieResultsSeed.movieResultFilled()
    
    func getMovieList(_ completion: @escaping (Result<MovieResults, NetworkError>) -> Void) {
        isSuccess ? completion(.success(result)) : completion(.failure(NetworkError(description: "genericError")))
    }
}

final class MovieListViewModelTests: XCTestCase {
    private var coordinatorSpy = MovieListCoordinatorSpy()
    private var viewControllerSpy = MovieListViewControllerSpy()
    private var serviceMock = MovieListServiceMock()
    
    private lazy var sut: MovieListViewModeling = {
        let viewModel = MovieListViewModel(coordinator: coordinatorSpy, service: serviceMock)
        viewModel.viewController = viewControllerSpy
        return viewModel
    }()
    
    func testGetMovieList_WhenServiceIsSuccessAndListIsNotEmpty_ShouldCallViewControllerWithMovies() {
        let moviesExpected = iMoviesSeeds.MovieResultsSeed.movieResultFilled()
        serviceMock.isSuccess = true
        
        sut.getMovieList()
        
        XCTAssertEqual(viewControllerSpy.showLoadingCallsCount, 2)
        XCTAssertEqual(viewControllerSpy.fillMovieListCallsCount, 1)
        XCTAssertEqual(viewControllerSpy.showErrorCallsCount, 0)
        XCTAssertEqual(viewControllerSpy.moviesReceived?.count, moviesExpected.movies.count)
        XCTAssertEqual(viewControllerSpy.moviesReceived, moviesExpected.movies)
    }
    
    func testGetMovieList_WhenServiceIsSuccessAndListIsEmpty_ShouldCallViewControllerWithNoMovies() {
        serviceMock.isSuccess = true
        serviceMock.result = iMoviesSeeds.MovieResultsSeed.movieResultEmpty()
        
        sut.getMovieList()
        
        XCTAssertEqual(viewControllerSpy.showLoadingCallsCount, 2)
        XCTAssertEqual(viewControllerSpy.fillMovieListCallsCount, 1)
        XCTAssertEqual(viewControllerSpy.showErrorCallsCount, 0)
        XCTAssertEqual(viewControllerSpy.moviesReceived?.count, 0)
    }
    
    func testGetMovieList_WhenServiceIsSuccessAndListIsFailure_ShouldCallViewControllerCallingErrorAlert() {
        let errorExpected = NetworkError(description: "genericError")
        serviceMock.isSuccess = false
        
        sut.getMovieList()
        
        XCTAssertEqual(viewControllerSpy.showLoadingCallsCount, 2)
        XCTAssertEqual(viewControllerSpy.fillMovieListCallsCount, 0)
        XCTAssertEqual(viewControllerSpy.showErrorCallsCount, 1)
        XCTAssertEqual(viewControllerSpy.errorReceived, errorExpected)
    }
    
    func testOpenMovieDetail_ShouldCallCoordinatorPassingMovie() {
        let movieExpected = iMoviesSeeds.MovieSeed.movieDetail()
        
        sut.openMovieDetail(movie: iMoviesSeeds.MovieSeed.movieDetail())
        
        XCTAssertEqual(coordinatorSpy.navigateToDetailCallsCount, 1)
        XCTAssertEqual(coordinatorSpy.detailReceived, movieExpected)
    }
}
