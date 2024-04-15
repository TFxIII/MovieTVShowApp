//
//  DBTVShow.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 10.04.2024.
//

import Foundation
import RealmSwift

class DBTVShow: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var language: String = ""
    @Persisted var title: String = ""
    @Persisted var originalTitle: String = ""
    @Persisted var overview: String = ""
    @Persisted var posterPath: String? = nil
    @Persisted var releaseDate: String? = nil
    @Persisted var adult: Bool = true
    @Persisted var backdropPath: String? = nil
    @Persisted var genreIds: List<Int> = List<Int>()
    @Persisted var popularity: Double = 0.0
    @Persisted var voteAverage: Double = 0.0
    @Persisted var voteCount: Double = 0.0
    @Persisted var originCountry: List<String> = List<String>()
    
    convenience init(tvShow: TVShow) {
        self.init()
        self.id = tvShow.id
        self.language = tvShow.originalLang
        self.title = tvShow.title
        self.originalTitle = tvShow.originalTitle
        self.overview = tvShow.overview
        self.posterPath = tvShow.posterPath
        self.releaseDate = tvShow.releaseDate
        self.adult = tvShow.adult
        self.backdropPath = tvShow.backdropPath
        self.genreIds.append(objectsIn: tvShow.genreIDS)
        self.popularity = tvShow.popularity
        self.voteAverage = tvShow.voteAverage
        self.voteCount = tvShow.voteCount
        self.originCountry.append(objectsIn: tvShow.originCountry)
    }
}
