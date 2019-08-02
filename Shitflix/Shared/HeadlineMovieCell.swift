//
//  MainMovieCell.swift
//  Shitflix
//
//  Created by BCamp User on 01/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

class HeadlineMovieCell: UICollectionViewCell {
    
    static let rID = "headliner"
    
    var movie: Movie? {
        didSet {
            update()
        }
    }
    
    var didAddToList: ((Movie) -> ())?
    var didPlay: ((Movie) -> ())?
    var didInfo: ((Movie) -> ())?
    
    private var poster = UIImageView()
    private var addToListBtn = UIButton() // TODO: create custom button
    private var playBtn = UIButton() // TODO: create custom button
    private var infoBtn = UIButton()
    
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
        self.contentView.addSubview(addToListBtn)
        self.contentView.addSubview(playBtn)
        self.contentView.addSubview(infoBtn)
        
        addToListBtn.addTarget(self, action: #selector(onAddToList), for: .touchUpInside)
        playBtn.addTarget(self, action: #selector(onPlay), for: .touchUpInside)
        infoBtn.addTarget(self, action: #selector(onInfo), for: .touchUpInside)
    }
    
    private func style() {
        self.clipsToBounds = true
        
        addToListBtn.setTitle("My list", for: .normal)
        playBtn.setTitle("Play", for: .normal)
        infoBtn.setTitle("Info", for: .normal)
        
        self.backgroundColor = .red
    }
    
    private func update() {
        guard movie != nil else { return }
        
        TheMovieDatabase.fetchImage(from: self.movie!.posterPath, ofSize: .w500) { result in
            switch result {
            case .success(let image):
                self.poster.image = image
            case .failure( _):
                print("Failure while retrieving movie image from url \(self.movie!.posterPath)")
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w = self.bounds.width
        let h = self.bounds.height
        
        poster.frame = CGRect(
            x: 0,
            y: 0,
            width: w,
            height: h
        )
        addToListBtn.frame = CGRect(
            x: w * 0.05,
            y: h * 0.85,
            width: 30,
            height: 30
        )
        playBtn.frame = CGRect(
            x: w * 0.5 - 45,
            y: h * 0.85,
            width: 90,
            height: 30
        )
        infoBtn.frame = CGRect(
            x: w * 0.95 - 30,
            y: h * 0.85,
            width: 30,
            height: 30
        )
        
    }
    
    @objc func onAddToList() {
        print("movie \(movie?.title ?? "unknown") added to list")
        didAddToList?(self.movie!)
    }
    @objc func onPlay() {
        print("playing \(movie?.title ?? "unknown")")
        didPlay?(self.movie!)
    }
    @objc func onInfo() {
        print("info about movie \(movie?.title ?? "unknown")")
        didInfo?(self.movie!)
    }
    
}
