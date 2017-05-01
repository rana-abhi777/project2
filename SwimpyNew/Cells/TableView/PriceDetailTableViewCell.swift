//
//  PriceDetailTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/1/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class PriceDetailTableViewCell: UITableViewCell {
    
    //MARK:- outlets
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblNetTotalAmount: UILabel!
    @IBOutlet weak var lblShippingPrice: UILabel!

    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
