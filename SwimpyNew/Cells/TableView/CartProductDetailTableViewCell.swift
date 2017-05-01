//
//  CartProductDetailTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/30/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import DropDown

protocol CartProductTask : class {
    func updateQuantity(model : CartData? , index: Int)
    func removeProductFromCart(index: Int)
}

prefix operator /

prefix func /(str : String?) -> String {
    return str ?? ""
}
prefix func /(str : Int?) -> Int {
    return str ?? 0
}
prefix func /(str : Double?) -> Double {
    return str ?? 0.0
}

class CartProductDetailTableViewCell: BaseTableViewCell {
    
    var productDetails : ProductDetail?
    
    //MARK:- outlet
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var segmentcontrolQuantity: UISegmentedControl!
    
    @IBOutlet weak var viewSoldOut: UIView!
    @IBOutlet weak var lblProductSoldOut: UILabel!
    
    //MARK:- variables
   weak var delegate : CartProductTask?
    var data : CartData?
    var row = 0
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSoldOut.isHidden = true
        lblProductSoldOut.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:-  function
    func configureCell(model : CartData,index : Int) {
        row = index
        data = model
        self.hitApiToGetProductDetails(productId: /data?.productId) { (quantity) in
            let value = quantity as! Int ?? Int()
            self.lblProductSoldOut.isHidden = value != 0 ? true : false
            self.viewSoldOut.isHidden = value != 0 ? true : false
            self.lblStoreName.text = L10n.orderFrom.string + (/model.storeName) + " (" + (/model.colorSelected) + ")"
            self.lblProductName?.text = model.productName
            self.lblPrice.text = "$" + (model.total_price ?? L10n._0.string)
            self.lblQuantity.text = model.quantitySelected
            self.imgProduct.sd_setImage(with: URL(string : /model.imageOriginal))
        }
    }
    
    func hitApiToGetProductDetails(productId: String , completion: @escaping(Any?) -> ()){
        ApiManager().getDataOfURL(withApi: API.ProductDetail(APIParameters.ProductDetail(productId: productId).formatParameters()), failure: { (err) in
            print(err)
            
        }, success: {[unowned self] (model) in
            self.productDetails =  (model as? ProductDetail)
            completion(/self.productDetails?.quantity)
            }, method: Keys.Get.rawValue, loader: true)
        
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
        case SwitchValues.zero.rawValue :
            if lblQuantity.text == data?.quantity {
                UserFunctions.showAlert(message: L10n.maximumQuantityReached.string)
                return
            }
            lblQuantity.text = (/lblQuantity.text).toInt()?.advanced(by : 1).toString
            
        case SwitchValues.one.rawValue :
            if lblQuantity.text == L10n._1.string {
                UserFunctions.showAlert(message: L10n.minimumQuantityIsOne.string)
                return
            }
            lblQuantity.text = (((/lblQuantity.text).toInt() ?? 1) - 1).toString
        default:
            print("hello")
            break;
        }
        self.data?.quantitySelected = self.lblQuantity.text ?? L10n._1.string
        self.delegate?.updateQuantity(model: self.data,index : self.row)
        
    }
    
}
