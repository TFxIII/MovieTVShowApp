//
//  TrailerDetailCell.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 16.04.2024.
//

import UIKit
import YouTubeiOSPlayerHelper

class TrailerDetailCell: UITableViewCell {
    
    @IBOutlet weak var youTubePlayer: YTPlayerView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        youTubePlayer.setCornerRadius(16)
    }
}
