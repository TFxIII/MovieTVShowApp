//
//  TVShow.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 09.04.2024.
//

import Foundation

struct TVShowPage: Decodable {
    let page: Int
    let results: [TVShow]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TVShow: Decodable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let originCountry: [String]
    let originalLang: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Double

    init(tvShow: DBTVShow) {
        self.id = tvShow.id
        self.originalLang = tvShow.language
        self.title = tvShow.title
        self.originalTitle = tvShow.originalTitle
        self.overview = tvShow.overview
        self.posterPath = tvShow.posterPath
        self.releaseDate = tvShow.releaseDate
        self.adult = tvShow.adult
        self.backdropPath = tvShow.backdropPath
        self.genreIDS = Array(tvShow.genreIds)
        self.popularity = tvShow.popularity
        self.voteAverage = tvShow.voteAverage
        self.voteCount = tvShow.voteCount
        self.originCountry = Array(tvShow.originCountry)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "name"
        case originalTitle = "original_name"
        case overview = "overview"
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originCountry = "origin_country"
        case originalLang = "original_language"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
