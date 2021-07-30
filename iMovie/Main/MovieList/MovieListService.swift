//
//  MovieListService.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

protocol MovieListApi {
    func getMovieList(_ completion: @escaping (Result<MovieResults, NetworkError>) -> Void)
}

final class MovieListService: MovieListApi {
    private let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func getMovieList(_ completion: @escaping (Result<MovieResults, NetworkError>) -> Void) {
        let endpoint = PopularMoviesEndpoint(environment: Environment.production)
        
        service.performRequest(endpoint: endpoint, using: .useDefaultKeys) { (result: Result<MovieResults, NetworkError>) in
            switch result {
            case .success(let movieResult):
                completion(.success(movieResult))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
