//
//  MovieDetails.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import Foundation

struct MovieVideos: Decodable {
    let results: [MovieVideo]
}

struct MovieVideo: Decodable {
    let name: String
    let key: String
}

struct MovieDetails: Decodable {
    let id: Int
    let title: String
    let tagline: String?
    let overview: String
    let videos: MovieVideos
    let backdropPath: String
    let voteAverage: Double
    let voteCount: Int
    let releaseDate: String?
    
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
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }
}
