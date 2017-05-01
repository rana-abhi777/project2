//
//  CategoryCollectionViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 2/9/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    
    //MARK:- outlet
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let featuredHeight: CGFloat = Constant.featuredHeight
        let standardHeight: CGFloat = Constant.standardHegiht
        
        let delta = 1 - (featuredHeight - frame.height) / (featuredHeight - standardHeight)
        
        let minAlpha: CGFloat = Constant.minAlpha
        let maxAlpha: CGFloat = Constant.maxAlpha
        
        let alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        overlayView?.alpha = alpha
        let scale = max(delta, 0.5)
        lblCategoryName?.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    //MARK:-   functions
    func configureCell(model : Category) {
        lblCategoryName?.text = model.name
        guard let url = model.categoryImageOriginal   else { imgCategory?.backgroundColor = UIColor.gray
            return }
        imgCategory?.sd_setImage(with: URL(string : url))
    }
}
extension CategoryCollectionViewCell {
    struct Constant {
        static let featuredHeight: CGFloat = 280
        static let standardHegiht: CGFloat = 100
        
        static let minAlpha: CGFloat = 0.3
        static let maxAlpha: CGFloat = 0.75
    }
}
