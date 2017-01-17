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
    @IBOutlet weak var btnQuantitySelected: UIButton!
    
    //MARK:- variables
    var delegate : CartProductTask?
    var data : CartData?
    let selectQuantityDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.selectQuantityDropDown,
            
            ]
    }()
    var arrQuantity : [String] = [L10n._1.string]
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
        arrQuantity = model.arrQuantity.map {"\($0)"}
        lblProductName.text = model.productName ?? ""
        lblPrice.text = "$" + (model.base_price_unit ?? L10n._0.string)
        lblQuantity.text = model.quantitySelected 
        imgProduct.sd_setImage(with: URL(string : model.imageOriginal ?? ""))
        selectQuantityDropDown.anchorView = lblQuantity
        selectQuantityDropDown.bottomOffset = CGPoint(x: 0, y: 20)
        selectQuantityDropDown.dataSource = arrQuantity
    }
    
    //MARK:-  button action
    @IBAction func btnActionEdit(_ sender: AnyObject) {
        
    }
    
    @IBAction func btnActionSelectQuantity(_ sender: AnyObject) {
        
        selectQuantityDropDown.show()
        selectQuantityDropDown.selectionAction = { [unowned self] (index, item) in
            self.lblQuantity.text = "\(self.arrQuantity[index])"
            self.data?.quantitySelected = self.lblQuantity.text ?? ""
            self.delegate?.updateQuantity(model: self.data,index : self.row)
        }
    }
    
    @IBAction func btnActionRemove(_ sender: AnyObject) {
        self.delegate?.removeProductFromCart(index: row)
    }
}
