//
//  DetailsHeaderView.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 16.04.2024.
//

import UIKit

enum DetailsContentType {
    case movieDetails(MovieDetails)
    case tvShowDetails(TVShowDetails)
}

class DetailsHeaderView: UIView {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var voteIconImageView: UIImageView!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteCountImageView: UIImageView!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    var content: DetailsContentType? {
        didSet {
            guard let content = content else { return }
            updateUI(for: content)
        }
    }
    
    private func updateUI(for content: DetailsContentType) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        
        switch content {
        case .movieDetails(let movieDetails):
            posterImageView.load(path: movieDetails.backdropPath)
            if let formattedDate = formatDate(movieDetails.releaseDate ?? "", "MMM dd, yyyy") {
                releaseDateLabel.text = formattedDate
            } else {
                releaseDateLabel.text = "..."
            }
            voteCountLabel.text = "\(movieDetails.voteCount)"
            let roundedVoteAvarege = String(format: "%.1f", movieDetails.voteAverage)
            voteAverageLabel.text = roundedVoteAvarege
        case .tvShowDetails(let tvShowDetails):
            posterImageView.load(path: tvShowDetails.backdropPath)
            if let formattedDate = formatDate(tvShowDetails.firstAirDate ?? "", "MMM dd, yyyy") {
                releaseDateLabel.text = formattedDate
            } else {
                releaseDateLabel.text = "..."
            }
            voteCountLabel.text = "\(tvShowDetails.voteCount)"
            let roundedVoteAvarege = String(format: "%.1f", tvShowDetails.voteAverage)
            voteAverageLabel.text = roundedVoteAvarege
        }
        posterImageView.setCornerRadius(16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
    }
    
}
