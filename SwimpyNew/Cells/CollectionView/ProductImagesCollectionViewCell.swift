//
//  ProductImagesCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/14/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class ProductImagesCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var imgProduct: UIImageView!
    
    var productImages : ProductOtherImage? {
        didSet{
            
           // imgProduct?.image = UIImage(named: "47044774-image")
            imgProduct?.sd_setImage(with: URL(string : /productImages?.productOtherImageImageOriginal))
        }
    }

}
