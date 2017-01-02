//
//  DealsCollectionViewCell.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

protocol DealsProductTask {
    func updateLikeData(model : Products?, index : Int)
}

class DealsCollectionViewCell: UICollectionViewCell {
    
    //MARK:-  Outlet
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnNumberOfLikes: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var viewPriceDeductLine: UIView!
    @IBOutlet weak var lblOldPrice: UILabel!
    //MARK:- variables
    var data : Products?
    var delegate : DealsProductTask?
    var index = 0
    
    
    //MARK:-  function
    func configureCell(model : Products,row : Int) {
        data = model
        index = row
        lblProductName?.text = model.productName ?? ""
        let totalPrice = Int(model.total_price ?? "0") ?? 0
        let basePrice = Int(model.base_price_unit ?? "0") ?? 0
        if totalPrice < basePrice &&  totalPrice != 0 {
            lblOldPrice.isHidden = false
            viewPriceDeductLine.isHidden = false
            lblOldPrice.text = "$" + (model.base_price_unit ?? "0")
            lblPrice?.text = "$" + (model.total_price ?? "0")
        }
        else {
            lblOldPrice.isHidden = true
            viewPriceDeductLine.isHidden = true
        }
        
        btnNumberOfLikes.setTitle(model.totalLikes ?? "0", for: .normal)
        btnShare.setTitle(model.share ?? "0", for: .normal)
        guard let url = model.productImageOriginal else { imgProduct.backgroundColor = UIColor.black
            return }
        imgProduct?.sd_setImage(with: URL(string : url))
        if model.hasLiked == 0 {
            btnLike.setImage(UIImage(asset: .icLike), for: .normal)
        }
        else {
            btnLike.setImage(UIImage(asset: .icLikeOn), for: .normal)
        }
    }
    
    //MARK:-  Button Action
    @IBAction func btnActionLike(_ sender: AnyObject) {
        if data?.hasLiked == 0 {
            self.btnLike.setImage(UIImage(asset : .icLikeOn), for: .normal)
            let likeCount = (Int(self.data?.totalLikes ?? "0") ?? 0) + 1
            self.data?.totalLikes = "\(likeCount)"
            self.data?.hasLiked = 1
            self.btnNumberOfLikes?.setTitle(self.data?.totalLikes, for: .normal)
            self.delegate?.updateLikeData(model: self.data, index: self.index)
            ApiManager().getDataOfURL(withApi: API.LikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: {[unowned self] (model) in
//                    let likeCount = model as? String
//                    self.data?.totalLikes = likeCount
//                    self.delegate?.updateLikeData(model: self.data, index: self.index)
                }, method: "POST", loader: false)
        }
        else {
            self.btnLike.setImage(UIImage(asset : .icLike), for: .normal)
            let likeCount = (Int(self.data?.totalLikes ?? "1") ?? 1) - 1
            self.data?.totalLikes = "\(likeCount)"
            self.btnNumberOfLikes?.setTitle(self.data?.totalLikes ?? "0", for: .normal)
            self.data?.hasLiked = 0
            self.delegate?.updateLikeData(model: self.data, index: self.index)
            ApiManager().getDataOfURL(withApi: API.DislikeProduct(APIParameters.DislikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: {[unowned self] (model) in
//                    let likeCount = model as? String
//                    self.data?.totalLikes = likeCount
//                    self.delegate?.updateLikeData(model: self.data, index: self.index)
                }, method: "POST", loader: false)
        }
    }
    
    
    
    @IBAction func btnActionNoOfLike(sender: AnyObject) {
    }
    @IBAction func btnActionShare(sender: AnyObject) {
    }
    
}
