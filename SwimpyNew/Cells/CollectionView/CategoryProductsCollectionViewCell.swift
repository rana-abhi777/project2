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
    
    //MARK:-  variables
    var data : Products?
    
    //MARK:-  function
    
    func configureCell(model : Products) {
        data = model
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
        if btnLike.image(for: .normal) == UIImage(asset: .icLike) {
            ApiManager().getDataOfURL(withApi: API.LikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: {[unowned self] (model) in
                    self.btnLike.setImage(UIImage(asset : .icLikeOn), for: .normal)
                    print(model)
                }, method: "POST", loader: false)
        }
        else {
            ApiManager().getDataOfURL(withApi: API.DislikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: {[unowned self] (model) in
                    self.btnLike.setImage(UIImage(asset : .icLike), for: .normal)
                    print(model)
                }, method: "POST", loader: false)
        }
    }
    
    
    @IBAction func btnActionNoOfLike(_ sender: AnyObject) {
    }
    
    
    @IBAction func btnActionShare(_ sender: AnyObject) {
    }
    
}
