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
        viewCellLayout.layer.borderColor = UIColor.border()
        lblProductName?.text = /model.productName
        lblPrice?.text = "$" + (model.totalPrice ?? L10n._0.string)
        btnNumberOfLike?.setTitle(/model.totalLikes , for: .normal)
        btnNumberOfShare?.setTitle(model.share ?? L10n._0.string, for: .normal)
        guard let url = model.productImageOriginal else { imgProduct.backgroundColor = UIColor.black
            return }
        imgProduct?.sd_setImage(with: URL(string : url)) { (image, error, cache, url) in
            print(image)
        }
        btnLike.isSelected = model.likesStatus != 0
        
    }
    
    
    //MARK:- button actions
    @IBAction func actionBtnLike(_ sender: AnyObject) {
        btnLike.isSelected = data?.likesStatus == 1
        let likeCount = (/self.data?.totalLikes).toInt()?.advanced(by : /data?.likesStatus == 0 ? 1 : -1)
        self.data?.totalLikes = likeCount?.toString
        self.data?.likesStatus = /data?.likesStatus == 0 ? 1 : 0
        self.btnNumberOfLike?.setTitle(self.data?.totalLikes, for: .normal)
        self.delegate?.updateLikeData(model: self.data, index: self.index)
        ApiManager().getDataOfURL(withApi: API.LikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters(),type: /data?.likesStatus == 0), failure: { (err) in
            print(err)
            }, success: { (model) in
            }, method: Keys.Post.rawValue, loader: false)
    }
    
    
    
}
