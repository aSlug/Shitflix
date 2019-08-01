//
//  MovieCell.swift
//  Shitflix
//
//  Created by BCamp User on 01/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let rID = "movie"
    
    var movie: Movie? {
        didSet {
            update()
        }
    }
    
    var didSelectMovie: ((Movie) -> ())?
    
    private var poster = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.contentView.addSubview(poster)
    }
    
    private func style() {
        self.clipsToBounds = true
    }
    
    private func update() {
        poster.image = movie?.poster
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        poster.frame = CGRect(
            x: 0,
            y: 0,
            width: self.bounds.width,
            height: self.bounds.height
        )
        self.backgroundColor = .green
    }
    
}
