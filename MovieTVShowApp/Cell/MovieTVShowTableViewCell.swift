//
//  MovieTVShowTableViewCell.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import UIKit

class MovieTVShowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieSubtitleLabel: UILabel!
    
    @IBOutlet weak var voteLabel: TagLabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.setCornerRadius(4.0)
    }
    
    func setupCell(movie: Movie) {
        posterImageView.load(path: movie.posterPath)
        movieTitleLabel.text = movie.title
        movieSubtitleLabel.text = movie.overview
    }
}
