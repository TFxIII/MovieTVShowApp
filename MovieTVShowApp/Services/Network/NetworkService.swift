//
//  NetworkService.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 08.04.2024.
//

import Foundation
import Alamofire

typealias ResultClosure<T> = (Result<T, Error>) -> Void

class NetworkService {
    
    private func request<T: Decodable>(endpoint: Endpoint, completion: @escaping ResultClosure<T>) {
        AF.request(endpoint)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let success):
                    completion(.success(success))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
    func getMovies(completion: @escaping ResultClosure<MoviePage>) {
        request(endpoint: .movies, completion: completion)
    }
    
    func getTVShows(completion: @escaping ResultClosure<TVShowPage>) {
        request(endpoint: .tvShow, completion: completion)
    }
    
    func getMovieDetails(movieId: Int, completion: @escaping ResultClosure<MovieDetails>) {
        request(endpoint: .movieDetails(id: movieId), completion: completion)
    }
    
    func getTVShowDetails(tvShowId: Int, completion: @escaping ResultClosure<TVShowDetails>) {
        request(endpoint: .tvShowDetails(id: tvShowId), completion: completion)
    }
    
    func searchMovies(query: String, completion: @escaping ResultClosure<MoviePage>) {
        request(endpoint: .searchMovies(query: query), completion: completion)
    }
    
    func searchTVShows(query: String, completion: @escaping ResultClosure<TVShowPage>) {
        request(endpoint: .searchTVShow(query: query), completion: completion)
    }
}
