//
//  PopularProductCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

protocol PopularProductTask {
    func updateLikeData(model : Products?, index : Int)
}

class PopularProductCollectionViewCell: UICollectionViewCell {
    
    //MARK:- outlets
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnNumberOfShare: UIButton!
    @IBOutlet weak var btnNumberOfLike: UIButton!
    
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var viewPriceDeductLine: UIView!
    //MARK:- variables
    var data : Products?
    var delegate : PopularProductTask?
    var index = 0
    
    //MARK:-  function
    func configureCell(model : Products,row : Int) {
        data = model
        index = row
        lblProductName?.text = model.productName ?? ""
        let totalPrice = Int(model.total_price ?? L10n._0.string) ?? 0
        let basePrice = Int(model.base_price_unit ?? L10n._0.string) ?? 0
        if totalPrice < basePrice &&  totalPrice != 0 {
            lblOldPrice.isHidden = false
            viewPriceDeductLine.isHidden = false
            lblOldPrice.text = "$" + (model.base_price_unit ?? L10n._0.string)
            lblPrice?.text = "$" + (model.total_price ?? L10n._0.string)
        }
        else {
            lblOldPrice.isHidden = true
            viewPriceDeductLine.isHidden = true
        }
              
        btnNumberOfLike.setTitle(model.totalLikes ?? L10n._0.string, for: .normal)
        btnNumberOfShare.setTitle(model.share ?? L10n._0.string, for: .normal)
        guard let url = model.productImageOriginal else { imgProduct.backgroundColor = UIColor.black
            return }
        imgProduct?.sd_setImage(with: URL(string : url)) { (image, error, cache, url) in
            print(image)
        }
        if model.hasLiked == 0 {
            btnLike.setImage(UIImage(asset: .icLike), for: .normal)
        }
        else {
            btnLike.setImage(UIImage(asset: .icLikeOn), for: .normal)
        }
    }
    
    
    
    //MARK:-button actions
    @IBAction func actionBtnLike(_ sender: AnyObject) {
        if data?.hasLiked == 0 {
            self.btnLike.setImage(UIImage(asset : .icLikeOn), for: .normal)
            let likeCount = (Int(self.data?.totalLikes ?? L10n._0.string) ?? 0) + 1
            self.data?.totalLikes = "\(likeCount)"
            self.data?.hasLiked = 1
            self.btnNumberOfLike?.setTitle(self.data?.totalLikes, for: .normal)
            self.delegate?.updateLikeData(model: self.data, index: self.index)
            ApiManager().getDataOfURL(withApi: API.LikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in

                }, method: "POST", loader: false)
        }
        else {
            self.btnLike.setImage(UIImage(asset : .icLike), for: .normal)
            let likeCount = (Int(self.data?.totalLikes ?? L10n._1.string) ?? 1) - 1
            self.data?.totalLikes = "\(likeCount)"
            self.btnNumberOfLike?.setTitle(self.data?.totalLikes ?? L10n._0.string, for: .normal)
            self.data?.hasLiked = 0
            self.delegate?.updateLikeData(model: self.data, index: self.index)
            ApiManager().getDataOfURL(withApi: API.DislikeProduct(APIParameters.DislikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in

                }, method: "POST", loader: false)
        }
    }
    
    
    
}
