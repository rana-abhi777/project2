//
//  ProductLikeUserCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/16/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class ProductLikeUserCollectionViewCell: UICollectionViewCell {
    
     //MARK:- Outlets
    @IBOutlet weak var imgUser: CustomImageView!
    
    
    var likeUser : LikeUser? {
        didSet{
            imgUser?.sd_setImage(with: URL(string : /likeUser?.userImgOriginal))
            self.bringSubview(toFront: imgUser)
        }
    }
    
    
}
