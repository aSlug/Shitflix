//
//  MovieStrip.swift
//  Shitflix
//
//  Created by BCamp User on 01/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

class MovieStripCell: UICollectionViewCell {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    static let rID = "strip"
    
    var movies: [Movie]? {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layout.scrollDirection = .horizontal
        
        collectionView.register(MovieCell.self,
                                forCellWithReuseIdentifier: MovieCell.rID)
        
        collectionView.dataSource = self
        
        addSubview(collectionView)
    }
    
    private func style() {
        collectionView.backgroundColor = UIColor(hex: Palette.background)
        self.backgroundColor = UIColor(hex: Palette.background)
    }
    
    private func update() {
        // TODO
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /* select the size of the single movie cell */
        let w = 105
        layout.itemSize = CGSize(width: w, height: w * 3/2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.frame = bounds
    }
    
    // quick accessor to collectionView layout bypassing cast
    private var layout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
}

extension MovieStripCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.rID, for: indexPath) as! MovieCell
        movieCell.movie = movies?[indexPath.row]
        return movieCell
    }

}
