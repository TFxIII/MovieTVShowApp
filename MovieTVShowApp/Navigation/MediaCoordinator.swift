//
//  TabCoordinator.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import UIKit

protocol MediaCoordinatorProtocol: Coordinator {
    func showMovieTVShowViewController()
}

class MediaCoordinator: Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .media }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMovieTVShowsViewController()
    }
    
    func showMovieTVShowsViewController() {
        let movieTVShowViewController = MovieTVShowViewController.instantiate()
        movieTVShowViewController.selectMovieTVShowClosure = { [weak self] event in
            switch event {
            case .movieDetails(let movieId):
                self?.showMovieDetails(movieId)
            case .tvShowDetails(let tvShowId):
                self?.showTVShowDetails(tvShowId)
            }
        }
        navigationController.pushViewController(movieTVShowViewController, animated: true)
    }
    
    func showMovieDetails(_ movieId: Int) {
        let movieDetailsViewController = MovieDetailsViewController.instantiate()
        movieDetailsViewController.movieId = movieId
        movieDetailsViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func showTVShowDetails(_ tvShowId: Int) {
        let tvShowDetailsViewController = TVShowDetailsViewController.instantiate()
        tvShowDetailsViewController.tvShowId = tvShowId
        tvShowDetailsViewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(tvShowDetailsViewController, animated: true)
    }
}
