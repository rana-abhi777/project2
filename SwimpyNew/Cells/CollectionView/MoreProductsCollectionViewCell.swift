//
//  MoreProductsCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/16/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class MoreProductsCollectionViewCell: UICollectionViewCell {
    
    //MARK:- outlets
    
    @IBOutlet weak var imgProduct: CustomImageView!
    
    var storeProduct : MoreFromStore? {
        didSet{
            imgProduct?.sd_setImage(with: URL(string : /storeProduct?.imgOriginal))
        }
    }
    
    //MARK:-  function
    func configureCell(model: MoreFromStore) {
        guard let url = model.imgOriginal else { imgProduct?.backgroundColor = UIColor.gray
            return }
        imgProduct?.sd_setImage(with: URL(string : url))
    }

    
}
