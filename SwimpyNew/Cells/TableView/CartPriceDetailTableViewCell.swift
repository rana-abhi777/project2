//
//  CartPriceDetailTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/31/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class CartPriceDetailTableViewCell: UITableViewCell {
    
    //MARK:-  outlets
    @IBOutlet weak var lblItemTotalPrice: UILabel!
    @IBOutlet weak var btnMarkAsGift: UIButton!
    @IBOutlet weak var lblShippingPrice: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    
    //MARK:- VARIABLES
    var data : ProductDetail?
    
    
    //MARK:-  override function
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK:-  function
    func configureCell(model : ProductDetail) {
        data = model
        let shipPrice = model.shippingPrice ?? 0.0
        let quantity = Float(model.quantitySelected) ?? 0.0
        let totalPrice = model.total_price ?? 0.0
        let basePrice = model.base_price_unit ?? 0.0
        lblShippingPrice.text =  "$ " + "\((shipPrice * quantity))" + "USD"
        lblTotalPrice.text =  "$ " + "\((totalPrice * quantity))" + "USD" //multiply quantity later on
        lblItemTotalPrice.text = "$ " + "\((basePrice * quantity))" + "USD" //multiply quantity
    }
    
    //MARK:-  button action
    @IBAction func btnActionCheckOut(_ sender: AnyObject) {
        
    }
    
    @IBAction func btnActionMarkAsGift(_ sender: AnyObject) {
        if data?.flagMarkAsGift == true {
            btnMarkAsGift.setImage(UIImage(asset : .icCheckSmall0), for: .normal)
            data?.flagMarkAsGift = false
        }
        else {
            btnMarkAsGift.setImage(UIImage(asset : .icCheckSmall), for: .normal)
            data?.flagMarkAsGift = true
        }
        
    }
}
