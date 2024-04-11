//
//  TVShowDetailsViewController.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 10.04.2024.
//

import UIKit

class TVShowDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
//    var coordinator: MediaCoordinator?
    
    var tvShow: TVShow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTVShowData()
    }
    
    private func showTVShowData() {
        guard let tvShow = tvShow else { return }
        
        title = tvShow.title
        posterImageView.load(path: tvShow.posterPath)
        titleLabel.text = tvShow.originalTitle
        subtitleLabel.text = tvShow.overview
    }
}
