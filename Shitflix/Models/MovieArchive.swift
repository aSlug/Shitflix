//
//  MovieArchive.swift
//  Shitflix
//
//  Created by BCamp User on 01/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import Foundation

class MovieArchive {
    
    // singleton instance of the whole movie archive
    static let archive = MovieArchive()
    
    var headliner: Movie?
    var strips: [MovieStrip]?
    
    // TODO to be called whenever the movie archive changes (eg: new movie added to my list)
    var archiveDidUpdate: (() -> ())?
    
    init() {
        
        /* retrieve headliner */
        TMDService.getMovie(id: Constants.headlinerID, then: { result in
            switch result {
            case .success(let movie):
                self.headliner = movie
            case .failure( _):
                print("Failure while retrieving movie with id \(Constants.headlinerID)")
            }
        })
        
        /* retrieve strips */
        for movieGroupType in MovieGroupType.allCases {
            
            TMDService.getMovieStrip(for: movieGroupType, then: { result in
                switch result {
                case .success(let movies):
                    let strip = MovieStrip(name: movieGroupType.rawValue, movies: movies)
                    self.strips?.append(strip)
                case .failure( _):
                    print("Failure while retrieving movies for strip \(movieGroupType.rawValue)")
                }
            })
            
        }
        
    }
    
}
