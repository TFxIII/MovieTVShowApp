//
//  DetailsHeaderView.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 16.04.2024.
//

import UIKit

class DetailsHeaderView: UIView {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var voteIconImageView: UIImageView!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var realeaseDateLabel: UILabel!
    @IBOutlet weak var voteCountImageView: UIImageView!
    @IBOutlet weak var voteCountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
    }
}
