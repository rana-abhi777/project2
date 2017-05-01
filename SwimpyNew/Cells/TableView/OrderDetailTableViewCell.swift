//
//  OrderDetailTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/1/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class OrderDetailTableViewCell: UITableViewCell {

    //MARK:- outlets
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblPriceAndQuantity: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!

    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK:-   functions
    func configureCell(model : OrderDetail) {
        guard let quantity = model.quantity else { return }
        lblPriceAndQuantity.text = quantity  + " *" + " $" + /model.price
        
        let price = (quantity.toDouble() ?? 1.0)  * ((/model.price).toDouble() ?? 0.0)
        
        
        lblTotalPrice.text = "$" +   "\(price)"
        lblProductName?.text = /model.name
        guard let url = model.thumbnailImage   else {
            imgProduct?.backgroundColor = UIColor.gray
            return }
        imgProduct?.sd_setImage(with: URL(string : url))
    }


}
