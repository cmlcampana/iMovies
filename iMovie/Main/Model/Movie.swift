//
//  Movie.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

struct Movie: Decodable, Equatable {
    let id: Int
    let posterPath: String?
    let backdrop: String?
    let title: String
    let releaseDate: String?
    let rating: Double
    let overview: String
    
    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backDrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        posterPath = try? container.decode(String?.self, forKey: .posterPath) ?? ""
        backdrop = try? container.decode(String?.self, forKey: .backDrop) ?? ""
        title = try container.decode(String.self, forKey: .title)
        releaseDate = try? container.decode(String?.self, forKey: .releaseDate) ?? ""
        rating = try container.decode(Double.self, forKey: .rating)
        overview = try container.decode(String.self, forKey: .overview)
    }
}
