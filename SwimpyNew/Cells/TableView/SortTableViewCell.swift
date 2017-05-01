//
//  SortTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 2/1/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class SortTableViewCell: BaseTableViewCell {
    
    //MARK:- outlets
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imgTick: UIImageView!
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
