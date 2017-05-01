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
        lblProductName?.text = /model.productName
        
        let totalPrice = Int(model.total_price ?? L10n._0.string) ?? 0
        let basePrice = Int(model.base_price_unit ?? L10n._0.string) ?? 0
        
        lblOldPrice.text = "$" + (model.base_price_unit ?? L10n._0.string)
        lblPrice?.text = "$" + (model.total_price ?? L10n._0.string)
        lblOldPrice.isHidden = totalPrice >= basePrice
        viewPriceDeductLine.isHidden = totalPrice >= basePrice
        btnNumberOfLikes.setTitle(model.totalLikes ?? L10n._0.string, for: .normal)
        btnShare.setTitle(model.share ?? L10n._0.string, for: .normal)
        guard let url = model.productImageOriginal else { imgProduct.backgroundColor = UIColor.black
            return }
        imgProduct?.sd_setImage(with: URL(string : url))
         btnLike.isSelected = model.likesStatus != 0
       
    }
    
    //MARK:-  Button Action
    @IBAction func btnActionLike(_ sender: AnyObject) {
        if UserFunctions.checkInternet() {
        btnLike.isSelected = data?.likesStatus == 1
        let likeCount = (/self.data?.totalLikes).toInt()?.advanced(by : /data?.likesStatus == 0 ? 1 : -1)
        self.data?.totalLikes = likeCount?.toString
        self.data?.likesStatus = /data?.likesStatus == 0 ? 1 : 0
        self.btnNumberOfLikes?.setTitle(self.data?.totalLikes, for: .normal)
        self.delegate?.updateLikeData(model: self.data, index: self.index)
        ApiManager().getDataOfURL(withApi: API.LikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters(),type: /data?.likesStatus == 0), failure: { (err) in
            print(err)
            }, success: { (model) in
            }, method: Keys.Post.rawValue, loader: false)
        }else {
            UserFunctions.showAlert(message: L10n.yourInternetConnectionSeemsToBeOffline.string)
        }
    }
     
}
