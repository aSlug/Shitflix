//
//  MovieStrip.swift
//  Shitflix
//
//  Created by BCamp User on 01/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import Foundation

struct MovieStrip {
    
    let type: MovieStripType
    var movies: [Movie]?
    
}

/*
 NOTE: the order of the enums determines the
 order the sprips are enlisted
 */
enum MovieStripType: String, CaseIterable {
    case upcoming = "In arrivo"
    case latest = "Nuove uscite"
    case popular = "Popolari ora"
    case topRated = "Top rated"
}
