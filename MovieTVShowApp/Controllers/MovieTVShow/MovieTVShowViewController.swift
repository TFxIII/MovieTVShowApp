//
//  MovieTVShowViewController.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import UIKit
import ProgressHUD

class MovieTVShowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let networkService = NetworkService()
    private let storageService = StorageService()
    
    private var movies: [Movie] = []
    private var tvShows: [TVShow] = []
    
    var selectMovieTVShowClosure: ((MovieTVShowViewController.Event) -> Void)?
    
    weak var coordinator: MediaCoordinator?
    
    private var searchTimer: Timer?
    private let searchDelay: TimeInterval = 1.0
    
    @IBOutlet weak var searchMovieTVShowBar: UISearchBar!
    @IBOutlet weak var movieTVShowSegmentControl: UISegmentedControl!
    @IBOutlet weak var movieTVShowTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchMovieTVShowBar.delegate = self
        registerCells()
        fetchMovies()
        fetchTVShows()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch(movieTVShowSegmentControl.selectedSegmentIndex) {
        case 0:
            title = "Movies"
        case 1:
            title = "TV Shows"
        default:
            break
        }
    }
    
    @IBAction func toggleMovieTVShowSegmentControl(_ sender: Any) {
        switch(movieTVShowSegmentControl.selectedSegmentIndex) {
        case 0:
            title = "Movies"
            searchMovieTVShowBar.text = .none
            fetchMovies()
            movieTVShowTableView.reloadData()
        case 1:
            title = "TV Shows"
            searchMovieTVShowBar.text = .none
            fetchTVShows()
            movieTVShowTableView.reloadData()
        default:
            break
        }
    }
    
    private func performSearch(with searchText: String) {
        
        if searchText.isEmpty {
            fetchMovies()
            fetchTVShows()
        } else {
            switch movieTVShowSegmentControl.selectedSegmentIndex {
            case 0:
                searchMovies(with: searchText)
            case 1:
                searchTVShows(with: searchText)
            default:
                break
            }
        }
    }
    
    private func searchMovies(with searchText: String) {
        networkService.searchMovies(query: searchText, completion: { [weak self] result in
            switch result {
            case .success(let page):
                self?.movies = page.results
                self?.movieTVShowTableView.reloadData()
            case .failure(let error):
                self?.coordinator?.showError(error)
            }
        })
    }

    private func searchTVShows(with searchText: String) {
        networkService.searchTVShows(query: searchText, completion: { [weak self] result in
            switch result {
            case .success(let page):
                self?.tvShows = page.results
                self?.movieTVShowTableView.reloadData()
            case .failure(let error):
                self?.coordinator?.showError(error)
            }
        })
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        switch(movieTVShowSegmentControl.selectedSegmentIndex) {
        case 0:
            returnValue = movies.count
        case 1:
            returnValue = tvShows.count
        default:
            break
        }
        
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeue(MovieTVShowTableViewCell.self, forIndexPath: indexPath)
        
        switch(movieTVShowSegmentControl.selectedSegmentIndex) {
        case 0:
            let movie = movies[indexPath.row]
            cell.setupCell(for: .movie(movie))
        case 1:
            let tvShow = tvShows[indexPath.row]
            cell.setupCell(for: .tvShow(tvShow))
        default:
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetails(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToFavorites = UIContextualAction(style: .normal, title: "") { [weak self] _, _, completionHandler in
            self?.addToFavorites(indexPath: indexPath)
            completionHandler(true)
        }
        addToFavorites.image = UIImage(systemName: "star.square.fill")
        addToFavorites.backgroundColor = .systemBlue
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [addToFavorites])
        return swipeConfiguration
    }
    
    private func showDetails(indexPath: IndexPath) {
        switch(movieTVShowSegmentControl.selectedSegmentIndex) {
        case 0:
            guard movies.indices.contains(indexPath.row) else { return }
            let movie = movies[indexPath.row]
            selectMovieTVShowClosure?(.movieDetails(movieId: movie.id))
        case 1:
            guard tvShows.indices.contains(indexPath.row) else { return }
            let tvShow = tvShows[indexPath.row]
            selectMovieTVShowClosure?(.tvShowDetails(tvShowId: tvShow.id))
        default:
            break
        }
    }
    
    private func addToFavorites(indexPath: IndexPath) {
        switch(movieTVShowSegmentControl.selectedSegmentIndex) {
        case 0:
            guard movies.indices.contains(indexPath.row) else { return }
                   let movie = movies[indexPath.row]
                   storageService.save(movie: movie) {
                       ProgressHUD.liveIcon(icon: .added)
                   }
        case 1:
            guard tvShows.indices.contains(indexPath.row) else { return }
                   let tvShow = tvShows[indexPath.row]
                   storageService.save(tvShow: tvShow) {
                       ProgressHUD.liveIcon(icon: .added)
                   }
        default:
            break
        }
    }
    
    private func fetchMovies() {
        networkService.getMovies { [weak self] result in
            switch result {
            case .success(let page):
                self?.movies = page.results
                self?.movieTVShowTableView.reloadData()
            case .failure(let error):
                self?.coordinator?.showError(error)
            }
        }
    }
    
    private func fetchTVShows() {
        networkService.getTVShows { [weak self] result in
            switch result {
            case .success(let page):
                self?.tvShows = page.results
                self?.movieTVShowTableView.reloadData()
            case .failure(let error):
                self?.coordinator?.showError(error)
            }
        }
    }
    
    private func registerCells() {
        movieTVShowTableView.registerFromNib(MovieTVShowTableViewCell.self)
    }
}

extension MovieTVShowViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: searchDelay, repeats: false) { [weak self] _ in
            self?.performSearch(with: searchText)
        }
    }
}

extension MovieTVShowViewController {
    enum Event {
        case movieDetails(movieId: Int)
        case tvShowDetails(tvShowId: Int)
    }
}
