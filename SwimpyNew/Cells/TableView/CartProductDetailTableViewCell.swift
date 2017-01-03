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
    func updateQuantity(model : ProductDetail?)
    func gotoPreviousScreen()
}

class CartProductDetailTableViewCell: UITableViewCell {
    
    //MARK:- outlet
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnQuantitySelected: UIButton!
    
    //MARK:- variables
    var delegate : CartProductTask?
    var data : ProductDetail?
    let selectQuantityDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.selectQuantityDropDown,
            
            ]
    }()
    let arrQuantity = ["1", "2" , "3", "4" ,"5", "6", "7"]
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:-  function
    func configureCell(model : ProductDetail) {
        data = model
        lblStoreName.text = "Order from " + (model.storeName ?? "") + " (" + (model.colorSelected ?? "") + ")"
        lblProductName.text = model.productName ?? ""
        lblPrice.text = "$" + "\(model.base_price_unit ?? 0.0)"
        lblQuantity.text = model.quantitySelected 
        imgProduct.sd_setImage(with: URL(string : model.imageOriginal ?? ""))
        selectQuantityDropDown.anchorView = lblQuantity
        selectQuantityDropDown.bottomOffset = CGPoint(x: 0, y: 40)
        selectQuantityDropDown.dataSource = arrQuantity
        
    }
    
    //MARK:-  button action
    @IBAction func btnActionEdit(_ sender: AnyObject) {
        
    }
    
    @IBAction func btnActionSelectQuantity(_ sender: AnyObject) {
        
        selectQuantityDropDown.show()
        selectQuantityDropDown.selectionAction = { [unowned self] (index, item) in
            self.lblQuantity.text = self.arrQuantity[index]
//            self.reloadInputViews()
            self.data?.quantitySelected = self.lblQuantity.text ?? ""
            self.delegate?.updateQuantity(model: self.data)
        }
    }
    
    @IBAction func btnActionRemove(_ sender: AnyObject) {
        self.delegate?.gotoPreviousScreen()
    }
}
