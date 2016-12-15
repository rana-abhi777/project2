//
//  ProductImagesCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/14/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class ProductImagesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    
    func configureCell(model: ProductOtherImage) {
        guard let url = model.productOtherImageImageOriginal else { imgProduct.backgroundColor = UIColor.gray
            return }
        imgProduct?.sd_setImage(with: URL(string : url))
    }
}
