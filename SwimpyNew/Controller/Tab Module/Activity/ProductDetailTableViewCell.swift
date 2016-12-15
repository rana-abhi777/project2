//
//  ProductDetailTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/13/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgStoreLogo: CustomImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblStoreFollowers: UILabel!
    
    @IBOutlet weak var lblSelectedColor: UILabel!
    @IBOutlet weak var lblNumberOfShare: UILabel!
    
    @IBOutlet weak var lblSelectedQuantity: UILabel!
    @IBOutlet weak var imgShare: UIImageView!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblNumberOfLikes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func configureCell(model : ProductDetail) {
        lblDescription.text = model.describe
        lblPrice.text = "$" + (model.base_price_unit ?? "0")
        lblNumberOfLikes.text = "\(model.totalLikes ?? 0)"
        lblNumberOfShare.text = "\(model.share ?? 0)"
//        lblSelectedColor.text = model.color?[0] ?? ""
        if model.likesStatus == 0 {
            imgLike.image = UIImage(asset: .icLike)
        }
        else {
            imgLike.image = UIImage(asset: .icLikeOn)
        }
        imgShare.image = UIImage(asset: .icShare)
    }

    
    
    @IBAction func btnActionLike(_ sender: AnyObject) {
    }
    @IBAction func btnActionShare(_ sender: AnyObject) {
    }
    @IBAction func btnActionAddToCart(_ sender: AnyObject) {
    }
    @IBAction func btnActionBuyNow(_ sender: AnyObject) {
    }
}
