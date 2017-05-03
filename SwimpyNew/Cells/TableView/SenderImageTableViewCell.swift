//
//  SenderImageTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 4/10/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class SenderImageTableViewCell: UITableViewCell {
    
    //MARK:- outlets
    @IBOutlet weak var imgSender: CustomImageView!
    @IBOutlet weak var imgChat: CustomImageView!
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureCell(data : Message, storeImage : String?) {
        imgChat.frame.size = UIImage(urlString: data.imgOriginal ?? "")?.size ?? UIImage().size
        imgSender.frame.size = UIImage(urlString: storeImage ?? "")?.size ?? UIImage().size
        imgChat.sd_setImage(with: URL(string: data.imgOriginal ?? ""))
        imgSender.sd_setImage(with: URL(string: storeImage ?? ""))
    }
}
