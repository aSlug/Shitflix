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
        
        //TODO retrieve data
        
    }
    
}
