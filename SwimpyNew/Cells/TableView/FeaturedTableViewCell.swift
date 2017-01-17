
//
//  FeaturedTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/15/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
protocol FeaturedProductsTask {
    func updateLikeData(model : Products?, index : Int)
    func cellSelected(index : Int)
}

class FeaturedTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnNumberOfShare: UIButton!
    @IBOutlet weak var btnNumberOfLike: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    
    @IBOutlet weak var imgHeart: UIImageView!
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
        imgProduct?.sd_setImage(with: URL(string:model.productImageOriginal ?? ""))
        lblPrice?.text = "$ " + (model.base_price_unit ?? L10n._0.string)
        btnNumberOfLike.setTitle(model.totalLikes ?? "",for: .normal)
        btnNumberOfShare?.setTitle(model.share ?? "",for: .normal)
        lblProductName?.text = model.productName
        if model.hasLiked == 0 {
            btnLike.setImage(UIImage(asset: .icLike), for: .normal)
        }
        else {
            btnLike.setImage(UIImage(asset: .icLikeOn), for: .normal)
        }
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
        print("double tapped")
        animateLike()
       
    }
    func tappedOnCell() {
        self.delegate?.cellSelected(index: index)
    }
    func likeAction() {
        if data?.hasLiked == 0 {
            self.btnLike.setImage(UIImage(asset : .icLikeOn), for: .normal)
            let likeCount = (Int(self.data?.totalLikes ?? L10n._0.string) ?? 0) + 1
            self.data?.totalLikes = "\(likeCount)"
            self.data?.hasLiked = 1
            self.btnNumberOfLike?.setTitle(self.data?.totalLikes, for: .normal)
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
            self.btnNumberOfLike?.setTitle(self.data?.totalLikes ?? L10n._0.string, for: .normal)
            self.data?.hasLiked = 0
            self.delegate?.updateLikeData(model: self.data, index: self.index)
            
            ApiManager().getDataOfURL(withApi: API.DislikeProduct(APIParameters.DislikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                   
                }, method: "POST", loader: false)
        }
        
    }
    
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
    
    //MARK:- button actions
    @IBAction func btnActionLike(_ sender: AnyObject) {
        likeAction()
    }
    
    @IBAction func btnActionShare(_ sender: AnyObject) {
    }
}
