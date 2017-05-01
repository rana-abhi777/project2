//
//  InboxChatListTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 4/10/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class InboxChatListTableViewCell: UITableViewCell {

    //MARK:- outlets
    @IBOutlet weak var lblSenderName: UILabel!
    @IBOutlet weak var imgSender: UIImageView!
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(data : ChatList){
        lblSenderName.text = data.storeName ?? ""
        imgSender.sd_setImage(with: URL(string: data.imgOriginal ?? ""))
        imgSender.clipsToBounds = true
    }
    

}
