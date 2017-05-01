//
//  RelatedProductsCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/16/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit


protocol RelatedProductsTask {
    func updateLikeData(model : RelatedProducts?, index : Int)
}


class RelatedProductsCollectionViewCell: UICollectionViewCell {
    
    //MARK:- outlets
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnNumberOfLike: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnNumberOfShare: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    
    
    //MARK:- variables
    var data : RelatedProducts?
    var delegate : RelatedProductsTask?
    var index = 0
    
    //MARK:-  function
    
    func configureCell(model : RelatedProducts,row : Int) {
        data = model
        index = row
        lblProductName?.text = /model.productName 
        lblPrice?.text = "$" + (model.base_price_unit ?? L10n._0.string)
        btnNumberOfLike?.setTitle(model.totalLikes ?? L10n._0.string, for: .normal)
        btnNumberOfShare?.setTitle(model.share ?? L10n._0.string, for: .normal)
        guard let url = model.productImageOriginal else { imgProduct.backgroundColor = UIColor.black
            return }
        imgProduct?.sd_setImage(with: URL(string : url)) { (image, error, cache, url) in
            print(image)
        }
        btnLike.isSelected = model.hasLiked != 0
        
    }
    
    
    
    //MARK:- button action
    
    @IBAction func btnActionLike(_ sender: AnyObject) {
        if UserFunctions.checkInternet() {
        btnLike.isSelected = data?.hasLiked == 1
        
        let likeCount = (/self.data?.totalLikes).toInt()?.advanced(by : /data?.hasLiked == 0 ? 1 : -1)
        self.data?.totalLikes = likeCount?.toString
        self.data?.hasLiked = /data?.hasLiked == 0 ? 1 : 0
        self.btnNumberOfLike?.setTitle(self.data?.totalLikes, for: .normal)
        self.delegate?.updateLikeData(model: self.data, index: self.index)
        ApiManager().getDataOfURL(withApi: API.LikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters(),type: /data?.hasLiked == 0), failure: { (err) in
            print(err)
            }, success: { (model) in
            }, method: Keys.Post.rawValue, loader: false)
        }else {
            UserFunctions.showAlert(message: L10n.yourInternetConnectionSeemsToBeOffline.string)
        }
    }
}
