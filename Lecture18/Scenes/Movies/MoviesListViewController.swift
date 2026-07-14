//
//  MoviesListViewController.swift
//  Lecture18
//
//  Created by Lizi Chichua on 14/07/2026.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    private var movieApiManager: MovieAPIManagerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovies()
    }

    private func fetchMovies() {
        movieApiManager = MovieAPIManager()
        
        movieApiManager?.fetchMovies(for: .upcoming) { result in
            switch result {
            case .success(let movieResponse):
                print(movieResponse.movies)
            case .failure(let error):
                print(error)
            }
        }
    }
}
