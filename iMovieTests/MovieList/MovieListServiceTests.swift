//
//  MovieListServiceTests.swift
//  iMovieTests
//
//  Created by Camila Campana on 01/08/21.
//

import XCTest
@testable import iMovie

final class MovieListServiceTests: XCTestCase {
    private let serviceMock = NetworkServiceMock<MovieResults>()
    private lazy var sut = MovieListService(service: serviceMock)

    func testGetMovieList_WhenRequestAttemptSucceeds_ShouldCompleteWithSuccess() {
        let expectation = XCTestExpectation(description: "expect to complete with success")
        let resultExpected = iMoviesSeeds.MovieResultsSeed.movieResultFilled()
        var resultReceived: MovieResults?
        
        serviceMock.successModel = iMoviesSeeds.MovieResultsSeed.movieResultFilled()
        sut.getMovieList { result in
            guard case .success(let movieResult) = result else {
                XCTFail("Expected to complete with success, got failure instead")
                return
            }

            resultReceived = movieResult
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(resultReceived)
        XCTAssertEqual(resultReceived, resultExpected)
    }
    
    func testGetMovieList_WhenRequestAttemptFailure_ShouldCompleteWithFailure() {
        let expectation = XCTestExpectation(description: "expect to complete with failure")
        let expectedError = NetworkError(description: "genericError")
        var receivedError: NetworkError?

        serviceMock.errorModel = expectedError
        sut.getMovieList { result in
            guard case .failure(let error) = result else {
                XCTFail("Expected to complete with error, got success instead")
                return
            }

            receivedError = error
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(receivedError)
        XCTAssertEqual(receivedError, expectedError)
    }
}
