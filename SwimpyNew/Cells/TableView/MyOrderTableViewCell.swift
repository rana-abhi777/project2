//
//  MyOrderTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/31/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

protocol MyOrderTask {
    func cancelOrder(index: Int)
    func openDetails(productId : String?)
}

class MyOrderTableViewCell: UITableViewCell {

    //MARK:- outlets
    @IBOutlet weak var lblOrderFrom: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblOrderPlacedOn: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnCancelItem: UIButton!
    @IBOutlet weak var btnDetails: UIButton!
    @IBOutlet weak var constButtonTop: NSLayoutConstraint!
    @IBOutlet weak var constButtonHeight: NSLayoutConstraint!
    
    //MARK:- variables
    var delegate : MyOrderTask?
    var data : MyOrderList?
    var index : Int = 0
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK:- function
    func configureCell(model : MyOrderList, index : Int) {
        self.data = model
        self.index = index
        let str = calculateDate(time : /model.date)
        lblOrderPlacedOn.text = L10n.placedOn.string + str
        lblQuantity.text = model.quantity ?? ""
        btnStatus.setTitle(model.status ?? "", for: .normal)
        imgProduct.sd_setImage(with: URL(string: model.thumbnailImage ?? ""))
        lblProductName.text = /model.name + " (" + /model.color + ")"
        lblOrderFrom.text = L10n.orderFrom.string + /model.storeName
        lblPrice.text = "$" + /model.price
        if /model.status == "DELIVERED" {
            constButtonTop.constant = 0.0
            constButtonHeight.constant = 0.0
            btnDetails.isHidden = true
            btnCancelItem.isHidden = true
        }else {
            constButtonTop.constant = 20.0
            constButtonHeight.constant = 32.0
            btnDetails.isHidden = false
            btnCancelItem.isHidden = false
        }
    }

    //MARK:- button actions
    @IBAction func btnActionCancelItem(_ sender: AnyObject) {
        
        self.delegate?.cancelOrder(index : self.index)
    }
    @IBAction func btnActionDetails(_ sender: AnyObject) {
        self.delegate?.openDetails(productId: data?.productId)
    }
}
