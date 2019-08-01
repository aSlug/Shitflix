//
//  Movie.swift
//  Shitflix
//
//  Created by BCamp User on 01/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

struct Movie {
    
    let poster: UIImage?
    let adult: Bool?
    let overview: String?
    let releaseDate: Date?
    let genre: [String]?
    let id: Int?
    let originalTitle: String?
    let title: String?
    let backdrop: UIImage?
    let popularity: Int?
    let votes: Int?
    let video: Bool?
    let voteAvg: Double?
    
}


//TODO make it decodable
