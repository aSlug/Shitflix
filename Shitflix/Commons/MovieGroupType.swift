//
//  MovieStripType.swift
//  Shitflix
//
//  Created by BCamp User on 02/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import Foundation

/*
 NOTE: the order of the enums determines the
 order the categories are displayed
 */
enum MovieStripType: String, CaseIterable {
    case upcoming = "In arrivo"
    case latest = "Nuove uscite"
    case popular = "Popolari ora"
    case topRated = "Top rated"
}
