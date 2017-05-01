//
//  SearchLoaderTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/20/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class SearchLoaderTableViewCell: BaseTableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var lblSearching: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- functions
    func configureCell() {
        activityIndicator.startAnimating()
    }
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
