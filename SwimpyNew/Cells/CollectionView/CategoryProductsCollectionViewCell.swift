//
//  CategoryProductsCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/29/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class CategoryProductsCollectionViewCell: UICollectionViewCell {
    
    //MARK:-  Outlet
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnNumberOfLikes: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    
    //MARK:-  function
    func configureCell(model : Products) {
        lblProductName.text = model.productName ?? ""
        lblPrice.text = "$" + (model.total_price ?? "0")
        btnNumberOfLikes.setTitle(model.totalLikes, for: .normal)
    }
    
    //MARK:-  Button Action
    @IBAction func btnActionLike(sender: AnyObject) {
    }
    @IBAction func btnActionNoOfLike(sender: AnyObject) {
    }
    @IBAction func btnActionShare(sender: AnyObject) {
    }
    
}
