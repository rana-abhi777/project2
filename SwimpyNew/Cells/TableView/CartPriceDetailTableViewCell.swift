//
//  CartPriceDetailTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/31/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

protocol CartTask {
    func nextStep()
}

class CartPriceDetailTableViewCell: BaseTableViewCell {
    
    var delegate : CartTask?
    
    //MARK:-  override function
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK:-  button action
    @IBAction func btnActionCheckOut(_ sender: AnyObject) {
        self.delegate?.nextStep()
    }
    
   
}
