//
//  StoreProductCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/3/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

protocol StoreProductTask {
    func updateLikeData(model : StoreProducts?, index : Int)
}

class StoreProductCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnNumberOfShare: UIButton!
    @IBOutlet weak var btnNumberOfLike: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var viewCellLayout: UIView!
    //MARK:- variables
    var data : StoreProducts?
    var delegate : StoreProductTask?
    var index = 0
    
    //MARK:-  function
    
    func configureCell(model : StoreProducts,row : Int) {
        data = model
        index = row
        viewCellLayout.layer.cornerRadius = 4.0
        viewCellLayout.layer.borderWidth = 2.0
        viewCellLayout.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor

        lblProductName?.text = model.productName ?? ""
        lblPrice?.text = "$" + (model.totalPrice ?? "0")
        btnNumberOfLike?.setTitle(model.totalLikes ?? "", for: .normal)
        btnNumberOfShare?.setTitle(model.share ?? "0", for: .normal)
        guard let url = model.productImageOriginal else { imgProduct.backgroundColor = UIColor.black
            return }
        imgProduct?.sd_setImage(with: URL(string : url)) { (image, error, cache, url) in
            print(image)
        }
        if model.likesStatus == 0 {
            btnLike.setImage(UIImage(asset: .icLike), for: .normal)
        }
        else {
            btnLike.setImage(UIImage(asset: .icLikeOn), for: .normal)
        }
        
    }
    
    
    //MARK:- button actions
    @IBAction func actionBtnLike(_ sender: AnyObject) {
        if data?.likesStatus == 0 {
            self.btnLike.setImage(UIImage(asset : .icLikeOn), for: .normal)
            let likeCount = (Int(self.data?.totalLikes ?? "0") ?? 0) + 1
            self.data?.totalLikes = "\(likeCount)"
            self.data?.likesStatus = 1
            self.btnNumberOfLike?.setTitle(self.data?.totalLikes, for: .normal)
            
            self.delegate?.updateLikeData(model: self.data, index: self.index)
            ApiManager().getDataOfURL(withApi: API.LikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                    
                }, method: "POST", loader: false)
        }
        else {
            self.btnLike.setImage(UIImage(asset : .icLike), for: .normal)
            let likeCount = (Int(self.data?.totalLikes ?? "1") ?? 1) - 1
            self.data?.totalLikes = "\(likeCount)"
            self.btnNumberOfLike?.setTitle(self.data?.totalLikes ?? "0", for: .normal)
            self.data?.likesStatus = 0
            
            self.delegate?.updateLikeData(model: self.data, index: self.index)
            ApiManager().getDataOfURL(withApi: API.DislikeProduct(APIParameters.DislikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                   
                }, method: "POST", loader: false)
        }
    }
    
    
    
}
