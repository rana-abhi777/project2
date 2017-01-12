//
//  CategoryTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/24/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryTableViewCell: UITableViewCell {
    
    //MARK:-  Outlet
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var imgCategory: UIImageView!
    
    //MARK:-  Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:-   functions
    func configureCell(model : Category) {
        lblCategoryName?.text = model.name ?? ""
        guard let url = model.categoryImageOriginal   else { imgCategory?.backgroundColor = UIColor.black
            return }
        imgCategory?.sd_setImage(with: URL(string : url))
    }
}
