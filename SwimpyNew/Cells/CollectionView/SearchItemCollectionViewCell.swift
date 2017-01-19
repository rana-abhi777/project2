//
//  SearchItemCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/19/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
protocol SearchProductTask {
    func updateLikeData(model : Item?, index : Int)
}

class SearchItemCollectionViewCell: UICollectionViewCell {
    
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
    var data : Item?
    var delegate : SearchProductTask?
    var index = 0
    
    
    //MARK:-  function
    func configureCell(model : Item,row : Int) {
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
        
        btnNumberOfLikes.setTitle(model.totalLikes ?? L10n._0.string, for: .normal)
        btnShare.setTitle(model.share ?? L10n._0.string, for: .normal)
        guard let url = model.productImageOriginal else { imgProduct.backgroundColor = UIColor.black
            return }
        imgProduct?.sd_setImage(with: URL(string : url))
        if model.likesStatus == 0 {
            btnLike.setImage(UIImage(asset: .icLike), for: .normal)
        }
        else {
            btnLike.setImage(UIImage(asset: .icLikeOn), for: .normal)
        }
    }
    
    //MARK:-  Button Action
    @IBAction func btnActionLike(_ sender: AnyObject) {
        if data?.likesStatus == 0 {
            self.btnLike.setImage(UIImage(asset : .icLikeOn), for: .normal)
            let likeCount = (Int(self.data?.totalLikes ?? L10n._0.string) ?? 0) + 1
            self.data?.totalLikes = "\(likeCount)"
            self.data?.likesStatus = 1
            self.btnNumberOfLikes?.setTitle(self.data?.totalLikes, for: .normal)
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
            self.btnNumberOfLikes?.setTitle(self.data?.totalLikes ?? L10n._0.string, for: .normal)
            self.data?.likesStatus = 0
            self.delegate?.updateLikeData(model: self.data, index: self.index)
            ApiManager().getDataOfURL(withApi: API.DislikeProduct(APIParameters.DislikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                }, method: "POST", loader: false)
        }
    }
    
    
    
    @IBAction func btnActionNoOfLike(sender: AnyObject) {
    }
    @IBAction func btnActionShare(sender: AnyObject) {
    }
    
}
