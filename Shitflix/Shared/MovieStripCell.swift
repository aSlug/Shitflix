//
//  MovieStrip.swift
//  Shitflix
//
//  Created by BCamp User on 01/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

class MovieStripCell: UICollectionViewCell {
    
    static let rID = "strip"
    
    var strip: MovieStrip? {
        didSet {
            update()
        }
    }
    
    private let label = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
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
        collectionView.dataSource = self
        collectionView.register(MovieCell.self,
                                forCellWithReuseIdentifier: MovieCell.rID)
        
        addSubview(label)
        addSubview(collectionView)
    }
    
    private func style() {
        self.backgroundColor = UIColor(hex: Palette.background)
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        
        collectionView.backgroundColor = UIColor(hex: Palette.background)
    }
    
    private func update() {
        label.text = strip?.name
        collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /* size of the whole strip cell */
        let w = self.bounds.width
        let h = self.bounds.height
        
        /* set the layout of the title of the strip cell */
        label.frame = CGRect(x: 10, y: 0, width: w - 20, height: 17)
        
        /* set the layout of the strip of posters*/
        collectionView.frame = CGRect(x: 0, y: 17, width: w, height: h - 20)
        
        /* set size and margins of the single movie cell */
        let posterW = 105
        layout.itemSize = CGSize(width: posterW, height: posterW * 3/2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    // quick accessor to collectionView layout bypassing cast
    private var layout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
}

extension MovieStripCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return strip?.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.rID, for: indexPath) as! MovieCell
        movieCell.movie = strip?.movies?[indexPath.row]
        return movieCell
    }

}
