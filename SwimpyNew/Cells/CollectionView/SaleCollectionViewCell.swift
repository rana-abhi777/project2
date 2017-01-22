
//
//  SaleCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

protocol SalesTask {
    func updateLikeData(model : Products?, index : Int)
}


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
    var delegate : SalesTask?
    var index = 0
    
    //MARK:-  function
    
    func configureCell(model : Products,row : Int) {
        data = model
        index = row
        lblProductName?.text = model.productName ?? ""
        lblOriginalPrice?.text = "$" + (model.base_price_unit ?? L10n._0.string)
        lblDiscountPrice?.text = "$" + (model.total_price ?? L10n._0.string)
        
        btnNumberOfLike?.setTitle(model.totalLikes ?? "", for: .normal)
        
        btnNumberOfShare?.setTitle(model.share ?? L10n._0.string, for: .normal)
        guard let url = model.productImageOriginal else { self.imgProduct.backgroundColor = UIColor.black
            return }
        imgProduct?.sd_setImage(with: URL(string : url))
        if model.hasLiked == 0 {
            btnLike.setImage(UIImage(asset: .icLike), for: .normal)
        }
        else {
            btnLike.setImage(UIImage(asset: .icLikeOn), for: .normal)
        }
        
    }
    
    
    //MARK:- button actions
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
                }, success: {(model) in
                    
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
