//
//  StripCell.swift
//  Shitflix
//
//  Created by marco pinton on 03/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

protocol Strip: UICollectionViewCell {
    
    var movieStrip: MovieStrip? { get set }
    
}
