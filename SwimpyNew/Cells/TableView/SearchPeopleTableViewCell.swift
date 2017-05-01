//
//  SearchPeopleTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/19/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class SearchPeopleTableViewCell: BaseTableViewCell {
    
    //MARK:-  Outlet
    @IBOutlet weak var imgUser: CustomImageView!
    @IBOutlet weak var lblFolllowers: UILabel!
    @IBOutlet weak var lblcountry: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    
    //MARK:-  Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:-   functions
    func configureCell(model : UserSearchResult) {
        lblFolllowers.text = /model.totalFollowedBy  + L10n._Followers.string
        lblcountry.text = L10n.india.string
        lblUsername?.text = /model.name 
        guard let url = model.profileImageOriginal   else {
            imgUser?.backgroundColor = UIColor.gray
            return }
        imgUser?.sd_setImage(with: URL(string : url))
    }
    
    
}
