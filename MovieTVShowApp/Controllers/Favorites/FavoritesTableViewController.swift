//
//  FavoritesTableViewController.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import UIKit
import ProgressHUD

class FavoritesTableViewController: UITableViewController {
    
    private let storageService = StorageService()
    private var movies: [Movie] = []
    private var tvShows: [TVShow] = []
    
    var selectMovieTVShowClosure: ((FavoritesTableViewController.Event) -> Void)?
    
    weak var coordinator: FavoritesCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        fetchMoviesAndTVShows()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMoviesAndTVShows()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return movies.count
        case 1:
            return tvShows.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue(MovieTVShowTableViewCell.self, forIndexPath: indexPath)
        
        switch indexPath.section {
        case 0:
            let movie = movies[indexPath.row]
            cell.setupCell(for: .movie(movie))
        case 1:
            let tvShow = tvShows[indexPath.row]
            cell.setupCell(for: .tvShow(tvShow))
            return cell
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Movies"
        } else {
            return "TV Shows"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetails(section: indexPath.section, row: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let removeFromFavorites = UIContextualAction(style: .destructive, title: "") { [weak self] _, _, completionHandler in
            //            self?.removeMovie(indexPath: indexPath)
            switch indexPath.section {
            case 0:
                self?.removeMovie(indexPath: indexPath)
            case 1:
                self?.removeTVShow(indexPath: indexPath)
            default:
                break
            }
            completionHandler(true)
        }
        removeFromFavorites.image = UIImage(systemName: "trash")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [removeFromFavorites])
        return swipeConfiguration
    }
    
    private func showDetails(section: Int, row: Int) {
        switch section {
        case 0:
            guard movies.indices.contains(row) else { return }
            let movie = movies[row]
            selectMovieTVShowClosure?(.movieDetails(movieId: movie.id))
        case 1:
            guard tvShows.indices.contains(row) else { return }
            let tvShow = tvShows[row]
            selectMovieTVShowClosure?(.tvShowDetails(tvShowId: tvShow.id))
        default:
            break
        }
    }
    
    private func removeMovieItem(indexPath: IndexPath) {
        movies.remove(at: indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
    
    private func removeTVShowItem(indexPath: IndexPath) {
        tvShows.remove(at: indexPath.row)
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
    
    private func removeTVShow(indexPath: IndexPath) {
        guard tvShows.indices.contains(indexPath.row) else { return }
        let tvShow = tvShows[indexPath.row]
        storageService.delete(tvShowId: tvShow.id) { [weak self] result in
            switch result {
            case .success:
                self?.removeTVShowItem(indexPath: indexPath)
                ProgressHUD.liveIcon(icon: .succeed)
            case .failure:
                ProgressHUD.liveIcon(icon: .failed)
            }
        }
    }
    
    private func fetchMoviesAndTVShows() {
        storageService.fetchFavoriteMovies { [weak self] movies in
            self?.movies = movies.reversed()
        }
        storageService.fetchFavoriteTVShows { [weak self] tvShows in
            self?.tvShows = tvShows.reversed()
        }
        self.tableView.reloadData()
    }
    
    private func registerCells() {
        tableView.registerFromNib(MovieTVShowTableViewCell.self)
    }
}

extension FavoritesTableViewController {
    enum Event {
        case movieDetails(movieId: Int)
        case tvShowDetails(tvShowId: Int)
    }
}
