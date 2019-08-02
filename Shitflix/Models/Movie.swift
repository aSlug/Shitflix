//
//  Movie.swift
//  Shitflix
//
//  Created by BCamp User on 01/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

struct Movie {
    
    let posterPath: String
    let adult: Bool?
    let overview: String?
    let releaseDate: Date?
    let genre: [Int]
    let id: Int
    let originalTitle: String?
    let title: String
    let backdropPath: String?
    let popularity: Double?
    let votes: Int?
    let video: Bool?
    let voteAvg: Double?
    
}


extension Movie: Codable {
    
    enum Codingkeys: String, CodingKey {
        case poster = "poster_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
        case genre = "genre_ids"
        case id = "id"
        case originalTitle = "original_title"
        case title = "title"
        case backdrop = "backdrop_path"
        case popularity = "popularity"
        case votes = "vote_count"
        case video = "video"
        case voteAvg = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Codingkeys.self)
        posterPath = try values.decode(String.self, forKey: .poster)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        releaseDate = try values.decodeIfPresent(Date.self, forKey: .releaseDate)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        genre = try values.decodeIfPresent([Int].self, forKey: .genre) ?? []
        id = try values.decode(Int.self, forKey: .id)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        title = try values.decode(String.self, forKey: .title)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdrop)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        votes = try values.decodeIfPresent(Int.self, forKey: .votes)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        voteAvg = try values.decodeIfPresent(Double.self, forKey: .voteAvg)
    }
    
}
