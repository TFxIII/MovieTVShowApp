//
//  StorageService.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import Foundation
import RealmSwift

class StorageService {
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
}
    
    func save(movie: Movie, completion: (() -> Void)) {
        try? realm.write {
            let movieDB = DBMovie(movie: movie)
            realm.add(movieDB, update: .all)
            completion()
        }
    }
    
    func save(tvShow: TVShow, completion: (() -> Void)) {
        try? realm.write {
            let tvShowDB = DBTVShow(tvShow: tvShow)
            realm.add(tvShowDB, update: .all)
            completion()
        }
    }
    
    func delete(movieId: Int, completion: ((Result<Int, Error>) -> Void)) {
        if let movieDB = realm.object(ofType: DBMovie.self, forPrimaryKey: movieId) {
            try? realm.write {
                realm.delete(movieDB)
                completion(.success(movieId))
            }
        } else {
            completion(.failure(StorageError.noObject))
        }
    }
    
    func delete(tvShowId: Int, completion: ((Result<Int, Error>) -> Void)) {
        if let tvShowDB = realm.object(ofType: DBTVShow.self, forPrimaryKey: tvShowId) {
            try? realm.write {
                realm.delete(tvShowDB)
                completion(.success(tvShowId))
            }
        } else {
            completion(.failure(StorageError.noObject))
        }
    }
    
    func fetchFavoriteMovies(completion: (([Movie]) -> ())) {
        let favoriteMoviesDB = realm.objects(DBMovie.self)
        let favoriteMovies = Array(favoriteMoviesDB.map { Movie(dbMovie: $0) })
        return completion(favoriteMovies)
    }
    
    func fetchFavoriteTVShows(completion: (([TVShow]) -> ())) {
        let favoriteTVShowsDB = realm.objects(DBTVShow.self)
        let favoriteTVShow = Array(favoriteTVShowsDB.map { TVShow(tvShow: $0) })
        return completion(favoriteTVShow)
    }
}

