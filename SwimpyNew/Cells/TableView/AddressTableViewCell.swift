//
//  AddressTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/1/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

protocol ProcessOrder {
    func generateOrder()
}

class AddressTableViewCell: UITableViewCell {
    
    //MARK:- outlets
    @IBOutlet weak var lblCountryZipcode: UILabel!
    @IBOutlet weak var lblAddressLine2: UILabel!
    @IBOutlet weak var lblAddressLine1: UILabel!
    
    var delegate : ProcessOrder?
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(model : DefaultAddress) {
        lblAddressLine1.text = model.addressLine1
        lblAddressLine2.text = model.addressLine2
        lblCountryZipcode.text = /model.city + " , " + /model.state + " , " + /model.countryName + " - " + /model.zipcode
       
    }

    //MARK:- button action
    @IBAction func btnActionContinue(_ sender: AnyObject) {
        self.delegate?.generateOrder()
    }
}
