//
//  DetailsViewController.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
//    var coordinator: MediaCoordinator?
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showMovieData()
    }
    
    private func showMovieData() {
        guard let movie = movie else { return }
        
        title = movie.title
        posterImageView.load(path: movie.posterPath)
        titleLabel.text = movie.originalTitle
        subtitleLabel.text = movie.overview
    }
}
