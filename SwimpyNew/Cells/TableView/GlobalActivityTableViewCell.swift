//
//  GlobalActivityTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/13/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

protocol GlobalActivityTask {
    func redirectToItemScreen(itemID : String, idType : String)
    func openUserDetail(userID : String)
}

class GlobalActivityTableViewCell: BaseTableViewCell {

    //MARK:-  Outlet
    @IBOutlet weak var imgUser: CustomImageView!
    @IBOutlet weak var lblActivity: UILabel!
    @IBOutlet weak var imgItem: CustomImageView!
    @IBOutlet weak var lblTime: UILabel!
    
    var data : GlobalActivity?
    var index : Int = 0
    var delegate : GlobalActivityTask?
    
    //MARK:-  Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK:-   functions
    
    func configureCell(model : GlobalActivity,index : Int) {
        data = model
        self.index = index
        lblActivity.text = appendOptionalStrings(strings: [model.userName,model.text,model.itemName], separator: " ")
        
        imgItem?.sd_setImage(with: URL(string : /model.itemImgOriginal ))
        guard let timeAgo = model.time else { return }
        lblTime?.text = calculateTimeSince(time: timeAgo)
        guard let url = model.userImgOriginal   else {
            imgUser?.backgroundColor = UIColor.gray
            return }
        imgUser?.sd_setImage(with: URL(string : url))
    }
    
    func appendOptionalStrings(strings : [String?],separator : String) -> String{
        return strings.flatMap{$0}.joined(separator: separator)
    }
    
    
    @IBAction func btnActionOpenUser(_ sender: AnyObject) {
        if data?.userId != MMUserManager.shared.loggedInUser?.id {
            self.delegate?.openUserDetail(userID: /data?.userId )
        }
    }
    @IBAction func btnActionOpenItem(_ sender: AnyObject) {
        self.delegate?.redirectToItemScreen(itemID: /data?.itemId , idType: /data?.idType )
    }
    
}
