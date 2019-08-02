//
//  HomepageViewController.swift
//  Shitflix
//
//  Created by BCamp User on 01/08/2019.
//  Copyright © 2019 BCamp User. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {
    
    var movieArchive: MovieArchive = .archive
    
    override func loadView() {
        let v = HomepageView()
        movieArchive.archiveDidUpdate = {
            v.collectionView.reloadData()
        }
        self.view = v
    }
    
}
