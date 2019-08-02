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
    static let baseImgUrl = "http://image.tmdb.org/t/p/"
}

struct TMDResources {
    static let movie = "/movie"
    static let popular = "/movie/popular"
    static let upcoming = "/movie/upcoming"
    static let latest = "/movie/top_rated"
    static let topRated = "/movie/top_rated"
}
