//
//  TabBarPage.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import Foundation

enum TabBarPage {
    case media
    case favorites
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .media
        case 1:
            self = .favorites
        default:
            return nil
        }
    }
    
    var pageTitle: String {
        switch self {
        case .media:
            return "Media"
        case .favorites:
            return "Favorites"
        }
    }
    
    var pageOrder: Int {
        switch self {
        case .media:
            return 0
        case .favorites:
            return 1
        }
    }
    
    var image: String {
        switch self {
        case .media:
            return "play.house.fill"
        case .favorites:
            return "star.square.fill"
        }
    }
}
