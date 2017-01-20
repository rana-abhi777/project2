//
//  SearchLoaderTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/20/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class SearchLoaderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblSearching: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func configureCell() {
        activityIndicator.startAnimating()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
