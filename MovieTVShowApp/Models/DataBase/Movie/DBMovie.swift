//
//  DBMovie.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import Foundation
import RealmSwift

class DBMovie: Object {
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
    @Persisted var video: Bool = false
    
    convenience init(movie: Movie) {
        self.init()
        self.id = movie.id
        self.language = movie.originalLang
        self.title = movie.title
        self.originalTitle = movie.originalTitle
        self.overview = movie.overview
        self.posterPath = movie.posterPath
        self.releaseDate = movie.releaseDate
        self.adult = movie.adult
        self.backdropPath = movie.backdropPath
        self.genreIds.append(objectsIn: movie.genreIDS)
        self.popularity = movie.popularity
        self.voteAverage = movie.voteAverage
        self.voteCount = movie.voteCount
        self.video = movie.video
    }
}
