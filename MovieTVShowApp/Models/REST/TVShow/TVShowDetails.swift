//
//  TVShowDetails.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 16.04.2024.
//

import Foundation

struct TVShowVideos: Decodable {
    let results: [TVShowVideo]
}

struct TVShowVideo: Decodable {
    let name: String
    let key: String
}

struct TVShowDetails: Decodable {
    let id: Int
    let title: String
    let tagline: String?
    let overview: String
    let videos: TVShowVideos
    let backdropPath: String
    let voteAverage: Double
    let voteCount: Int
    let firstAirDate: String?
    
    var videoKey: String? {
        return videos.results.first?.key
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "name"
        case tagline = "tagline"
        case overview = "overview"
        case videos = "videos"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
    }
}
