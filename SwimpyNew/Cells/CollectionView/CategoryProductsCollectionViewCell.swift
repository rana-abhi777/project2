//
//  CategoryProductsCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/29/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

protocol CategoryProductsTask {
    func updateLikeData(model : Products?, index : Int)
}

class CategoryProductsCollectionViewCell: UICollectionViewCell {
    
    //MARK:-  Outlet
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnNumberOfLikes: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    
    //MARK:-  variables
    var delegate : CategoryProductsTask?
    var data : Products?
    var index = 0
    
    //MARK:-  function
    func configureCell(model : Products,row : Int) {
        data = model
        index = row
        lblProductName.text = model.productName ?? ""
        lblPrice.text = "$" + (model.base_price_unit ?? "0")
        btnNumberOfLikes.setTitle(model.totalLikes, for: .normal)
        btnShare?.setTitle(model.share ?? "0", for: .normal)
        guard let url = model.productImageOriginal else { imgProduct.backgroundColor = UIColor.black
            return }
        imgProduct.sd_setImage(with: URL(string : url)) { (image, error, cache, url) in
            print(image)
        }
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
//                     self.delegate?.updateLikeData(model: self.data, index: self.index)
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
    
    
    @IBAction func btnActionNoOfLike(_ sender: AnyObject) {
    }
    
    
    @IBAction func btnActionShare(_ sender: AnyObject) {
    }
    
}
