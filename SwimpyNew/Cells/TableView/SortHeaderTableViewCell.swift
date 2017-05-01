//
//  SortHeaderTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 2/1/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class SortHeaderTableViewCell: BaseTableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var lblHeaderTitle: UILabel!
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
