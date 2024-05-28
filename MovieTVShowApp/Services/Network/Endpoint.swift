//
//  Endpoint.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 16.04.2024.
//

import Foundation
import Alamofire

enum Endpoint: URLRequestConvertible {
    case movies
    case tvShow
    case movieDetails(id: Int)
    case tvShowDetails (id: Int)
    case searchMovies(query: String)
    case searchTVShow(query: String)
    
    var path: String {
        switch self {
        case .movies:
            return "/discover/movie"
        case .tvShow:
            return "/discover/tv"
        case .movieDetails (let id):
            return "/movie/\(id)"
        case .tvShowDetails (let id):
            return "/tv/\(id)"
        case .searchMovies:
            return "/search/movie"
        case .searchTVShow:
            return "/search/tv"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [URLQueryItem] {
        
        var parameters: [URLQueryItem] = []
        
        switch self {
        case .movies, .tvShow:
            parameters = [
            ]
        case .movieDetails:
            parameters = [
                .init(name: "append_to_response", value: "videos,credits")
            ]
        case .tvShowDetails:
            parameters = [
                .init(name: "append_to_response", value: "videos")
            ]
        case .searchMovies(let query):
            parameters = [
                .init(name: "query", value: query),
            ]
        case .searchTVShow(let query):
            parameters = [
                .init(name: "query", value: query),
            ]
        }
        
        parameters.append(.init(name: "api_key", value: Constants.apiKey))
        return parameters
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseURL = try Constants.baseURL.asURL()
        let fullURL = baseURL.appendingPathComponent(path)
        
        var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters
        
        var request = URLRequest(url: try components?.asURL() ?? fullURL)
        request.httpMethod = method.rawValue
        
        return request
    }
}
