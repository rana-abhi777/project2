//
//  DealsCollectionViewCell.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class DealsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var btnNumberOfLikes: UIButton!
       @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    
    
    @IBAction func btnActionLike(sender: AnyObject) {
    }
    @IBAction func btnActionNoOfLike(sender: AnyObject) {
    }
    @IBAction func btnActionShare(sender: AnyObject) {
    }

}
