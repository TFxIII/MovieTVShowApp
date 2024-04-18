//
//  StorageError.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import Foundation

enum StorageError: Error {
    case noObject
    
    var errorDescription: String {
        switch self {
        case .noObject:
            return NSLocalizedString("No object found in the storage.", comment: "Storage error")
        }
    }
}
