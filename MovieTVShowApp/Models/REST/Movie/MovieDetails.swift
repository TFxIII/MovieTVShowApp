//
//  MovieDetails.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import Foundation

struct Videos: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let name: String
    let key: String
}

struct MovieDetails: Decodable {
    let id: Int
    let title: String
    let tagline: String?
    let overview: String
    let videos: Videos
    let backdropPath: String
    
    var videoKey: String? {
        return videos.results.first?.key
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case tagline = "tagline"
        case overview = "overview"
        case videos = "videos"
        case backdropPath = "backdrop_path"
    }
}
