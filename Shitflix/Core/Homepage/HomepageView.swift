//
//  HomepageView.swift
//  Shitflix
//
//  Created by BCamp User on 01/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

class HomepageView: UIView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // TODO
        setup()
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layout.scrollDirection = .vertical
        
        collectionView.register(MovieStripCell.self,
                                forCellWithReuseIdentifier: MovieStripCell.rID)
        collectionView.register(HeadlineMovieCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeadlineMovieCell.rID)
        
        collectionView.dataSource = self
        
        addSubview(collectionView)
    }
    
    private func style() {
        /* permit the headliner to overflow in the safe area */
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = UIColor(hex: Palette.background)
        self.backgroundColor = UIColor(hex: Palette.background)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout.headerReferenceSize = CGSize(width: bounds.width, height: 550)
        layout.itemSize = CGSize(width: bounds.width, height: 160)
        collectionView.frame = bounds
    }
    
    // quick accessor to collectionView layout bypassing cast
    private var layout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
}

extension HomepageView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieArchive.archive.strips.count
    }
    
    // strips
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let stripCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieStripCell.rID, for: indexPath) as! MovieStripCell
        stripCell.movies = MovieArchive.archive.strips[indexPath.row].movies
        return stripCell
    }
    
    // headliner
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeadlineMovieCell.rID, for: indexPath) as! HeadlineMovieCell
        header.movie = MovieArchive.archive.headliner
        return header
    }
    
}
