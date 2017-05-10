//
//  UserChatTextTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 4/10/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class UserChatTextTableViewCell: UITableViewCell {
    
    //MARK:- outlets
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var imgUser: CustomImageView!
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(data : Message) {
        lblMessage.text = data.message ?? StringNames.empty.rawValue
        imgUser.sd_setImage(with: URL(string: MMUserManager.shared.loggedInUser?.profilePicURLOriginal ?? StringNames.empty.rawValue))    }
    
}
