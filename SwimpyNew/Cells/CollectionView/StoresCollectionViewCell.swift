//
//  StoresCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Sierra 4 on 22/04/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
class StoresCollectionViewCell: UICollectionViewCell {
    
    var storesModel: StoreFollowStatus?
       
    @IBOutlet weak var imgViewProduct: UIImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblStoreDescription: UILabel!
    @IBOutlet weak var btnMessageToStore: UIButton!
    @IBOutlet weak var btnShopToStore: CustomButton!
    @IBOutlet weak var btnFollowStore: CustomButton!
    
    func configureCell(model:StoreFollowStatus , row:Int){
        storesModel = model
        lblStoreName.text = model.storeName ?? ""
        imgViewProduct.sd_setImage(with: URL(string: /storesModel?.profilePicURLThumbnail))
    }
}
