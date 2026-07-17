//
//  MoviesListViewController.swift
//  Lecture18
//
//  Created by Lizi Chichua on 14/07/2026.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var movieApiManager: MovieAPIManagerProtocol?
    private var upcomingMovies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var topRatedMovies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var popularMovies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        fetchMovies()
    }
    
    private func setUpTableView() {
        tableView.dataSource = self
        
        tableView.register(
            UINib(nibName: "UpcomingTableViewCell", bundle: nil),
            forCellReuseIdentifier: "UpcomingTableViewCell"
        )
        
        tableView.register(
            UINib(nibName: "TopRatedTableViewCell", bundle: nil),
            forCellReuseIdentifier: "TopRatedTableViewCell"
        )
        
        tableView.register(
            UINib(nibName: "PopularTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PopularTableViewCell"
        )
    }

    private func fetchMovies() {
        movieApiManager = MovieAPIManager()
        
        movieApiManager?.fetchMovies(for: .upcoming) { result in
            switch result {
            case .success(let movieResponse):
                print(movieResponse.movies)
                self.upcomingMovies = movieResponse.movies
            case .failure(let error):
                print(error)
            }
        }
        
        movieApiManager?.fetchMovies(for: .topRated) { result in
            switch result {
            case .success(let movieResponse):
                print(movieResponse.movies)
                self.topRatedMovies = movieResponse.movies
            case .failure(let error):
                print(error)
            }
        }
        
        movieApiManager?.fetchMovies(for: .popular) { result in
            switch result {
            case .success(let movieResponse):
                print(movieResponse.movies)
                self.popularMovies = movieResponse.movies
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MovieCategory.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as! UpcomingTableViewCell
//            cell.movies = upcomingMovies
//            return cell
//        } else if indexPath.row == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTableViewCell", for: indexPath) as! TopRatedTableViewCell
//            cell.movies = topRatedMovies
//            return cell
//        } else if indexPath.row == 2 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
//            cell.movies = popularMovies
//            return cell
//        }
//        return UITableViewCell()
        
        guard let category = MovieCategory(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch category {
        case .upcoming:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingTableViewCell", for: indexPath) as! UpcomingTableViewCell
            cell.movies = upcomingMovies
            return cell
        case .topRated:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopRatedTableViewCell", for: indexPath) as! TopRatedTableViewCell
            cell.movies = topRatedMovies
            return cell
        case .popular:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
            cell.movies = popularMovies
            return cell
        }
    }
}
