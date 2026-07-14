//
//  MovieAPIManager.swift
//  Lecture18
//
//  Created by Lizi Chichua on 14/07/2026.
//

import Foundation

/*
 https://api.themoviedb.org/3/movie/upcoming?api_key=cc369969178d5bf3c9cc3c18d264a837

 https://api.themoviedb.org/3/movie/top_rated?api_key=cc369969178d5bf3c9cc3c18d264a837

 https://api.themoviedb.org/3/movie/popular?api_key=cc369969178d5bf3c9cc3c18d264a837
 */

enum MovieCategory {
    case upcoming
    case topRated
    case popular
    
    var queryParameter: String {
        switch self {
        case .upcoming: "upcoming"
        case .topRated: "top_rated"
        case .popular: "popular"
        }
    }
}

protocol MovieAPIManagerProtocol {
    func fetchMovies(for category: MovieCategory, completion: @escaping (Result<MovieResponse, Error>) -> ())
}

final class MovieAPIManager: MovieAPIManagerProtocol {
    func fetchMovies(
        for category: MovieCategory,
        completion: @escaping (Result<MovieResponse, any Error>) -> ()
    ) {
        let urlString = "https://api.themoviedb.org/3/movie/\(category.queryParameter)?api_key=cc369969178d5bf3c9cc3c18d264a837"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
