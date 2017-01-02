//
//  ProfileStoreCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/2/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class ProfileStoreCollectionViewCell: UICollectionViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet weak var imgStoreCoverPic: UIImageView!
    @IBOutlet weak var imgStoreProfilePic: CustomImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblNumberOfFollowers: UILabel!
    
    
    
    //MARK:-  function
    
    func configureCell(model : StoreDetail) {
        lblStoreName.text = model.storeName ?? ""
//        lblDescription.text = model?.describe ?? ""
        lblNumberOfFollowers.text = (model.totalFollow ?? "") + " followers"
        imgStoreCoverPic.sd_setImage(with: URL(string: model.coverPicURLOriginal ?? ""))
        imgStoreProfilePic.sd_setImage(with: URL(string: model.profilePicURLThumbnail ?? ""))
    }
}
