//
//  SearchStoreCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/19/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class SearchStoreCollectionViewCell: UICollectionViewCell {
    
    //MARK:- OUTLETS
    @IBOutlet weak var imgStoreCoverPic: UIImageView!
    @IBOutlet weak var imgStoreProfilePic: CustomImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblNumberOfFollowers: UILabel!
    
    
    
    //MARK:-  function
    
    func configureCell(model : Store) {
        lblStoreName.text = model.storeName ?? ""
        lblNumberOfFollowers.text = (model.totalFollow ?? "") + L10n._Followers.string
        imgStoreCoverPic.sd_setImage(with: URL(string: model.coverPicURLOriginal ?? ""))
        imgStoreProfilePic.sd_setImage(with: URL(string: model.profilePicURLThumbnail ?? ""))
    }
}
