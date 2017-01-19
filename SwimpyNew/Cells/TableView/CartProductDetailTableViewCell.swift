//
//  CartProductDetailTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/30/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import DropDown

protocol CartProductTask {
    func updateQuantity(model : CartData? , index: Int)
    func removeProductFromCart(index: Int)
}

class CartProductDetailTableViewCell: UITableViewCell {
    
    //MARK:- outlet
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var segmentcontrolQuantity: UISegmentedControl!
    
    //MARK:- variables
    var delegate : CartProductTask?
    var data : CartData?
    var row = 0
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:-  function
    func configureCell(model : CartData,index : Int) {
        row = index
        data = model
        lblStoreName.text = L10n.orderFrom.string + (model.storeName ?? "") + " (" + (model.colorSelected ?? "") + ")"

        lblProductName.text = model.productName ?? ""
        lblPrice.text = "$" + (model.base_price_unit ?? L10n._0.string)
        lblQuantity.text = model.quantitySelected 
        imgProduct.sd_setImage(with: URL(string : model.imageOriginal ?? ""))

    }
    
    //MARK:-  button action
    @IBAction func btnActionEdit(_ sender: AnyObject) {
        
    }
    
    
    @IBAction func btnActionRemove(_ sender: AnyObject) {
        self.delegate?.removeProductFromCart(index: row)
    }
    
    
    @IBAction func segmentControlAction(_ sender: AnyObject) {
        switch segmentcontrolQuantity.selectedSegmentIndex
        {
        case 0:
            if lblQuantity.text == data?.quantity {
                UserFunctions.showAlert(message: L10n.maximumQuantityReached.string)
                return
            }
            lblQuantity.text = "\((Int(lblQuantity.text ?? "0") ?? 0) + 1)"
        case 1:
            if lblQuantity.text == "1" {
                UserFunctions.showAlert(message: L10n.minimumQuantityIsOne.string)
                return
            }
            lblQuantity.text = "\((Int(lblQuantity.text ?? "1") ?? 1) - 1)"
        default:
            print("hello")
            break; 
        }
        self.data?.quantitySelected = self.lblQuantity.text ?? "1"
        self.delegate?.updateQuantity(model: self.data,index : self.row)
        
    }
    
}
