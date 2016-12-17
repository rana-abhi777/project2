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
    
    
    //MARK:-  function
    func configureCell(model: ProductOtherImage) {
        guard let url = model.productOtherImageImageOriginal else { imgProduct.backgroundColor = UIColor.gray
            return }
        print(url)
        imgProduct?.sd_setImage(with: URL(string : url)) { (image, error, cache, url) in
            print(image)
        }
      //  imgProduct?.sd_setImage(with: URL(string : url))
    }
}
