//
//  SearchLoaderCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/20/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class SearchLoaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblSearching: UILabel!
    @IBOutlet weak var activityIndicatorSearch: UIActivityIndicatorView!
    
    func configureCell() {
        activityIndicatorSearch.startAnimating()
    }
    
}
