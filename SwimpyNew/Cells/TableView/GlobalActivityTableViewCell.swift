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
}

class GlobalActivityTableViewCell: UITableViewCell {

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
    
    func appendOptionalStrings(strings : [String?],separator : String) -> String{
        return strings.flatMap{$0}.joined(separator: separator)
    }
    
    func configureCell(model : GlobalActivity,index : Int) {
        data = model
        self.index = index
        lblActivity.text = appendOptionalStrings(strings: [model.userName,model.text,model.itemName], separator: " ")
        
        guard let url = model.userImgOriginal   else {
            imgUser?.backgroundColor = UIColor.gray
            return }
        imgUser?.sd_setImage(with: URL(string : url))
        
        guard let itemUrl = model.itemImgOriginal else {
             imgItem?.backgroundColor = UIColor.gray
            return
        }
        imgItem?.sd_setImage(with: URL(string : itemUrl))
        guard let timeAgo = model.time else { return }
        
        lblTime?.text = calculateTimeSince(time: timeAgo)
    }

    @IBAction func btnActionOpenItem(_ sender: AnyObject) {
        self.delegate?.redirectToItemScreen(itemID: (data?.itemId ?? ""), idType: (data?.idType ?? ""))
    }
    
}