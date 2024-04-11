//
//  FavoritesViewController.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import UIKit
import ProgressHUD

class FavoritesTableViewController: UITableViewController {
    
    private let storageService = StorageService()
    private var movies: [Movie] = []
    
    var selectMovieTVShowClosure: ((FavoritesTableViewController.Event) -> Void)?
    
    var coordinator: FavoritesCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeue(MovieTVShowTableViewCell.self, forIndexPath: indexPath)
        cell.setupCell(movie: movie)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetails(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeFromFavorites = UIContextualAction(style: .destructive, title: "") { [weak self] _, _, completionHandler in
            self?.removeMovie(indexPath: indexPath)
            completionHandler(true)
        }
        removeFromFavorites.image = UIImage(systemName: "trash")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [removeFromFavorites])
        return swipeConfiguration
    }
    
    private func showDetails(indexPath: IndexPath) {
        guard movies.indices.contains(indexPath.row) else { return }
        let movie = movies[indexPath.row]
        selectMovieTVShowClosure?(.details(movie))
    }
    
    private func removeMovieItem(indexPath: IndexPath) {
        movies.remove(at: indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
    private func removeMovie(indexPath: IndexPath) {
        guard movies.indices.contains(indexPath.row) else { return }
        let movie = movies[indexPath.row]
        storageService.delete(movieId: movie.id) { [weak self] result in
            switch result {
            case .success:
                self?.removeMovieItem(indexPath: indexPath)
                ProgressHUD.liveIcon(icon: .succeed)
            case .failure:
                ProgressHUD.liveIcon(icon: .failed)
            }
        }
    }
    
    private func fetchMovies() {
        storageService.fetchFavoriteMovies { [weak self] movies in
            self?.movies = movies.reversed()
            self?.tableView.reloadData()
        }
    }
    
    private func registerCells() {
        tableView.registerFromNib(MovieTVShowTableViewCell.self)
    }
}

extension FavoritesTableViewController {
    enum Event {
        case details(Movie)
    }
}
