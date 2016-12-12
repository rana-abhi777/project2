//
//  PopularProductCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class PopularProductCollectionViewCell: UICollectionViewCell {
    
    //MARK:- outlets
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnNumberOfShare: UIButton!
    @IBOutlet weak var btnNumberOfLike: UIButton!
    
    //MARK:- variables
    var data : Products?
    
    //MARK:-  function
    
    func configureCell(model : Products) {
        data = model
        lblProductName?.text = model.productName ?? ""
        lblPrice?.text = "$" + (model.total_price ?? "0")
        btnNumberOfLike.setTitle(model.totalLikes ?? "0", for: .normal)
        guard let url = model.productImageOriginal else { imgProduct.backgroundColor = UIColor.black
            return }
        imgProduct?.sd_setImage(with: URL(string : url)) { (image, error, cache, url) in
            print(image)
        }
    }
    
    
    
    //MARK:-button actions
    @IBAction func actionBtnLike(_ sender: AnyObject) {
        if btnLike.image(for: .normal) == UIImage(asset: .icLike) {
            ApiManager().getDataOfURL(withApi: API.LikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: {[unowned self] (model) in
                    self.btnLike.setImage(UIImage(asset : .icLikeOn), for: .normal)
                    print(model)
                }, method: "POST", loader: false)
        }
        else {
            ApiManager().getDataOfURL(withApi: API.DislikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: {[unowned self] (model) in
                    self.btnLike.setImage(UIImage(asset : .icLike), for: .normal)
                    print(model)
                }, method: "POST", loader: false)
        }
    }
    
    
    
}
