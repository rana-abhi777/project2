
//
//  FeaturedTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/15/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import Foundation
protocol FeaturedProductsTask {
    func updateLikeData(model : Products?, index : Int)
    func cellSelected(index : Int)
    func shareProduct(model : Products?, index : Int)
    func buyProduct(model : Products?, index : Int)
}

class FeaturedTableViewCell: BaseTableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnNumberOfShare: UIButton!
    @IBOutlet weak var btnNumberOfLike: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var lblNumberOfLikes: UILabel!
    @IBOutlet weak var lblIsFeatured: UILabel!
    
    
    //MARK:- variables
    var data : Products?
    var delegate : FeaturedProductsTask?
    var index = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK:-   functions
    func configureCell(model : Products,row : Int) {
        data = model
        index = row
        imgProduct?.sd_setImage(with: URL(string: /model.productImageOriginal ))
        lblPrice?.text = "$ " + (model.base_price_unit ?? L10n._0.string)
        btnNumberOfLike.setTitle(model.totalLikes,for: .normal)
        lblNumberOfLikes.text = model.totalLikes
        btnNumberOfShare?.setTitle(model.share,for: .normal)
        btnLike.isSelected = model.hasLiked != 0
        model.hasLiked != 0 ? btnLike.setTitle(StringNames.awsome.rawValue, for: .selected) : btnLike.setTitle(StringNames.like.rawValue, for: .normal)
        lblProductName?.text = model.productName
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(FeaturedTableViewCell.tapOn))
        doubleTapGesture.numberOfTapsRequired = 2
        imgProduct?.addGestureRecognizer(doubleTapGesture)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(FeaturedTableViewCell.tappedOnCell))
        singleTapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTapGesture)
        doubleTapGesture.requiresExclusiveTouchType = true
        singleTapGesture.require(toFail: doubleTapGesture)
        imgHeart.isHidden = true
        
    }
    func tapOn() {
        imgHeart.isHidden = false
        animateLike()
        
    }
    func tappedOnCell() {
        self.delegate?.cellSelected(index: index)
    }
    func likeAction() {
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
    }
    
    //MARK:- button actions
    @IBAction func btnActionLike(_ sender: AnyObject) {
        if UserFunctions.checkInternet() {
            likeAction()
        }else {
            UserFunctions.showAlert(message: L10n.yourInternetConnectionSeemsToBeOffline.string)
        }
    }
    
    @IBAction func btnActionShare(_ sender: AnyObject) {
        self.delegate?.shareProduct(model: data, index: index)
        
    }
    
    
    @IBAction func btnActionBuy(_ sender: AnyObject) {
        self.delegate?.buyProduct(model: data, index: index)
    }
    
}



//MARK: - animation like
extension FeaturedTableViewCell {
    
    func animateLike() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {() -> Void in
            self.imgHeart.isHidden = false
            self.imgHeart.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
            self.imgHeart.alpha = 1.0
            
            }, completion: {(_ finished: Bool) -> Void in
                UIView.animate(withDuration: 0.1, delay: 0, options: .allowUserInteraction, animations: {() -> Void in
                    self.imgHeart.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                    
                    }, completion: {(_ finished: Bool) -> Void in
                        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {() -> Void in
                            self.imgHeart.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
                            self.imgHeart.alpha = 0.0
                            
                            }, completion: {(_ finished: Bool) -> Void in
                                self.imgHeart.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                                self.imgHeart.isHidden = true
                                self.likeAction()
                        })
                })
        })
    }
}
