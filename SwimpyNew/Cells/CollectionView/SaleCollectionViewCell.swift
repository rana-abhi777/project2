//
//  SaleCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class SaleCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnNumberOfShare: UIButton!
    @IBOutlet weak var btnNumberOfLike: UIButton!
    @IBOutlet weak var lblOriginalPrice: UILabel!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    
    //MARK:- variables
    var data : Products?
    
    
    //MARK:-  function
    
    func configureCell(model : Products) {
        data = model
        lblProductName?.text = model.productName ?? ""
        lblOriginalPrice?.text = "$" + (model.total_price ?? "0")
        lblDiscountPrice?.text = "$" + (model.repost_price ?? "0")
        btnNumberOfLike?.setTitle(model.totalLikes ?? "", for: .normal)
        guard let url = model.productImageOriginal else { imgProduct.backgroundColor = UIColor.black
            return }
        imgProduct?.sd_setImage(with: URL(string : url)) { (image, error, cache, url) in
            print(image)
        }
    }
    
    
    //MARK:- button actions
    @IBAction func actionBtnLike(_ sender: AnyObject) {
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
    
    
    
}
