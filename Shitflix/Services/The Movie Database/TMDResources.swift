//
//  Resource.swift
//  Shitflix
//
//  Created by BCamp User on 02/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import Foundation

struct TMDEndpoints {
    static let apiEndpoint = "https://api.themoviedb.org/3"
    static let baseImgUrl = "https://image.tmdb.org/t/p/"
}

struct TMDResources {
    static let movie = "/movie/{movie_id}"
    static let popular = "/movie/popular"
    static let upcoming = "/movie/upcoming"
    static let nowPlaying = "/movie/now_playing"
    static let latest = "/movie/latest"
    static let topRated = "/movie/top_rated"
    static let reccomendations = "/movie/{movie_id}/recommendations"
    static let searchMovie = "/search/movie"
}
