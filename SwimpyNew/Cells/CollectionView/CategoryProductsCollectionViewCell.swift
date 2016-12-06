//
//  CategoryProductsCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/29/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import Kingfisher

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
        lblPrice.text = "$" + (model.base_price_unit ?? "0")
        btnNumberOfLikes.setTitle(model.totalLikes, for: .normal)
        guard let url = model.productImageOriginal else { imgProduct.backgroundColor = UIColor.black
            return }
//        imgProduct.kf.indicatorType = .activity
//        imgProduct.kf.setImage(with: URL(string : url))
        imgProduct.sd_setImage(with: URL(string : url)) { (image, error, cache, url) in
            print(image)
        }
    }
    
     //MARK:-  Button Action
    @IBAction func btnActionLike(_ sender: AnyObject) {
    }
   
    
    @IBAction func btnActionNoOfLike(_ sender: AnyObject) {
    }
    
    
    @IBAction func btnActionShare(_ sender: AnyObject) {
    }
    
}
