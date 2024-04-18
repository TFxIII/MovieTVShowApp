//
//  Cast.swift
//  MovieTVShowApp
//
//  Created by Trynus Fedir on 17.04.2024.
//

import Foundation

struct Cast: Decodable  {
    let id: Int
    let adult: Bool
    let knownForDepartment: String
    let name: String
    let profilePath: String?
    let character: String?
    let job: String?
    
    var imageURL: URL? {
        guard let profilePath = profilePath else {
            return nil
        }
        return URL(string: Constants.imageBaseURL + profilePath)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        adult = try container.decode(Bool.self, forKey: .adult)
        knownForDepartment = try container.decode(String.self, forKey: .knownForDepartment)
        name = try container.decode(String.self, forKey: .name)
        profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
        character = try container.decodeIfPresent(String.self, forKey: .character)
        job = try container.decodeIfPresent(String.self, forKey: .job)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case adult = "adult"
        case knownForDepartment = "known_for_department"
        case name = "name"
        case profilePath = "profile_path"
        case character = "character"
        case job = "job"
    }
}
