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

//myCode
protocol DealsProtocol{
    func getStatusOfCollectionView(status : Int)
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
    var myDelegate:DealsProtocol?
    var index = 0
    var isItemController = 0
    var counter = 0
    
    //MARK:-  function
    func configureCell(model : Products,row : Int) {
        self.layer.borderColor = UIColor.border()
        data = model
        index = row
        lblProductName?.text = /model.productName
        let totalPrice = model.total_price?.toInt() ?? 0
        let basePrice = Int(model.base_price_unit ?? L10n._0.string) ?? 0
        lblPrice?.text = "$" + (model.total_price ?? L10n._0.string)
        lblOldPrice.text = "$" + (model.base_price_unit ?? L10n._0.string)
        lblOldPrice.isHidden = totalPrice >= basePrice
        viewPriceDeductLine.isHidden = totalPrice >= basePrice
        btnNumberOfLikes.setTitle(model.totalLikes ?? L10n._0.string, for: .normal)
        btnShare.setTitle(model.share ?? L10n._0.string, for: .normal)
        guard let url = model.productImageOriginal else {
            imgProduct.backgroundColor = UIColor.black
            return
        }
        if isItemController == 1 {
            btnLike.setImage(#imageLiteral(resourceName: "ic_like_on"), for: .normal)
        }
        imgProduct?.sd_setImage(with: URL(string : url))
        btnLike.isSelected = model.hasLiked != 0
    }
    
    //MARK:-  Button Action
    @IBAction func btnActionLike(_ sender: AnyObject) {
        if UserFunctions.checkInternet() {
            if isItemController == 1{
                if self.btnLike.currentImage != #imageLiteral(resourceName: "ic_like"){
                    self.btnLike.setImage(#imageLiteral(resourceName: "ic_like"), for: .normal)
                    var likes = Int((self.btnNumberOfLikes.titleLabel?.text) ?? "")! - 1
                    self.btnNumberOfLikes.setTitle(String(likes), for: .normal)
                    ApiManager().getDataOfURL(withApi: API.LikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters(), type: true), failure: { (err) in
                        print("error")
                        
                    }, success: { (model) in
                    }, method: Keys.Post.rawValue, loader: false)
                }
            }
            else{
                btnLike.isSelected = data?.hasLiked == 1
                let likeCount = (/self.data?.totalLikes).toInt()?.advanced(by : /data?.hasLiked == 0 ? 1 : -1)
                self.data?.totalLikes = likeCount?.toString
                self.data?.hasLiked = /data?.hasLiked == 0 ? 1 : 0
                self.btnNumberOfLikes?.setTitle(self.data?.totalLikes, for: .normal)
                self.delegate?.updateLikeData(model: self.data, index: self.index)
                ApiManager().getDataOfURL(withApi: API.LikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters(),type: /data?.hasLiked == 0), failure: { (err) in
                    print(err)
                }, success: { (model) in
                }, method: Keys.Post.rawValue, loader: false)
            }
        }else {
            UserFunctions.showAlert(message: L10n.yourInternetConnectionSeemsToBeOffline.string)
        }
    }
    
}

extension UICollectionViewCell {
    
    @IBInspectable  var cornerRadius: CGFloat? {
        get {
            return self.cornerRadius
        }
        set {
            layer.cornerRadius = newValue ?? 0.0
        }
    }
    
    @IBInspectable  var borderWidth: CGFloat?{
        get {
            return self.borderWidth
        }
        set {
            layer.borderWidth = newValue ?? 0.0
        }
    }
    
    @IBInspectable  var borderColor: UIColor? {
        get {
            return self.borderColor
        }
        set {
            layer.borderColor = newValue!.cgColor
        }
    }
}



