//
//  UIImageView+Load.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import UIKit
import SDWebImage

extension UIImageView {
    func load(path: String?) {
        guard let path = path else { return }
        sd_setImage(with: URL(string: Constants.imageBaseURL + path))
    }
}
