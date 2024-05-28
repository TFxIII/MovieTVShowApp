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
    @IBOutlet weak var voteAverageImageView: UIImageView!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.setCornerRadius(16.0)
    }
    
    func setupCell(for content: CellContentType) {
        switch content {
        case .movie(let movie):
            posterImageView.load(path: movie.posterPath)
            movieTitleLabel.text = movie.title
            movieSubtitleLabel.text = movie.overview
            movieSubtitleLabel.textColor = .systemGray
            let roundedVoteAverage = String(format: "%.1f", movie.voteAverage)
            voteAverageLabel.text = roundedVoteAverage
            if let formattedDate = formatDate(movie.releaseDate ?? " ", "MMM, yyyy") {
                releaseDateLabel.text = formattedDate
            } else {
                releaseDateLabel.text = "..."
            }
            
        case .tvShow(let tvShow):
            posterImageView.load(path: tvShow.posterPath)
            movieTitleLabel.text = tvShow.title
            movieSubtitleLabel.text = tvShow.overview
            movieSubtitleLabel.textColor = .systemGray
            let roundedVoteAverage = String(format: "%.1f", tvShow.voteAverage)
            voteAverageLabel.text = roundedVoteAverage
            if let formattedDate = formatDate(tvShow.releaseDate ?? " ", "MMM, yyyy") {
                releaseDateLabel.text = formattedDate
            } else {
                releaseDateLabel.text = "..."
            }
        }
    }
}

enum CellContentType {
    case movie(Movie)
    case tvShow(TVShow)
}
