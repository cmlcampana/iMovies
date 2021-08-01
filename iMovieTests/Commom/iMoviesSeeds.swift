//
//  iMoviesSeeds.swift
//  iMovieTests
//
//  Created by Camila Campana on 01/08/21.
//

import XCTest
@testable import iMovie

struct iMoviesSeeds {
    struct MovieResultsSeed {
        static func movieResultFilled() -> MovieResults {
            let result = try! JSONDecoder().decode(MovieResults.self, from: Data("""
            {
                "page": 1,
                "total_pages": 1,
                "total_results": 2,
                "results": [
                    {
                        "id": 0,
                        "backdrop_path": "/8s4h9friP6Ci3adRGahHARVd76E.jpg",
                        "overview": "bla bla bla bla bla",
                        "poster_path": "/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg",
                        "release_date": "2021-07-08",
                        "title": "Movie 1",
                        "vote_average": 7.7
                    },
                    {
                        "id": 1,
                        "backdrop_path": "/8s4h9friP6Ci3adRGahHARVd76E.jpg",
                        "overview": "bla bla bla bla bla",
                        "poster_path": "/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg",
                        "release_date": "2021-07-08",
                        "title": "Movie 2",
                        "vote_average": 7.7
                    }
                ]
            }
            """.utf8))
            
            return result
        }
        
        static func movieResultEmpty() -> MovieResults {
            let result = try! JSONDecoder().decode(MovieResults.self, from: Data("""
            {
                "page": 0,
                "total_pages": 0,
                "total_results": 0,
                "results": []
            }
            """.utf8))
            
            return result
        }
    }
    
    struct MovieSeed {
        static func movieDetail() -> Movie {
            let result = try! JSONDecoder().decode(Movie.self, from: Data("""
            {
                "id": 0,
                "backdrop_path": "/8s4h9friP6Ci3adRGahHARVd76E.jpg",
                "overview": "bla bla bla bla bla",
                "poster_path": "/5bFK5d3mVTAvBCXi5NPWH0tYjKl.jpg",
                "release_date": "2021-07-08",
                "title": "Movie 1",
                "vote_average": 7.7
            }
            """.utf8))
            
            return result
        }
    }
}
