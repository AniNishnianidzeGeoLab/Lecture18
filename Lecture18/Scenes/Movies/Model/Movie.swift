//
//  Movie.swift
//  Lecture18
//
//  Created by Lizi Chichua on 14/07/2026.
//

// MARK: - MovieResponse
struct MovieResponse: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

// MARK: - Movie
struct Movie: Decodable {
    let name, overview: String
    let posterImage: String
    let votes: Double

    enum CodingKeys: String, CodingKey {
        case name = "original_title"
        case overview
        case posterImage = "poster_path"
        case votes = "vote_average"
    }
}
