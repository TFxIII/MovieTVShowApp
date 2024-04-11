//
//  TabCoordinator.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import UIKit

class TabCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMovieTVShows()
    }
    
    func showMovieTVShows() {
        let movieTVShowViewController = MovieTVShowViewController.instantiate()
        movieTVShowViewController.coordinator = self
        navigationController.pushViewController(movieTVShowViewController, animated: false)
    }
    
    func showDetails(movie: Movie) {
        let detailsViewController = DetailsViewController.instantiate()
        detailsViewController.coordinator = self
        detailsViewController.movie = movie
        navigationController.pushViewController(detailsViewController, animated: true)
    }
    
    func showFavorites() {
        let favoritesViewController = FavoritesTableViewController.instantiate()
        favoritesViewController.coordinator = self
        navigationController.pushViewController(favoritesViewController, animated: true)
    }
    
    func showError(_ error: Error) {
        let title = "Error"
        let message = error.localizedDescription
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(.init(title: "Cancel", style: .cancel))
        navigationController.present(alertViewController, animated: true)
    }
}
