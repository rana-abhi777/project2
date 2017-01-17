//
//  SettingsTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/5/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit


class SettingsTableViewCell: UITableViewCell {
    
    //MARK:- outlet
    @IBOutlet weak var lblSettingCategory: UILabel!
    @IBOutlet weak var btnSwitch: UIButton!
    
    
    var data : String = ""
    var index = 0
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:-  function
    func configureCell(model : String,row : Int) {
        data = model
        index = row
        lblSettingCategory.text = model
        if row == 2 {
            (MMUserManager.shared.loggedInUser?.notification == L10n._1.string) ? btnSwitch.setImage(UIImage(asset : .icToggleOn), for: .normal) : btnSwitch.setImage(UIImage(asset : .icToggleOff), for: .normal)
            btnSwitch.isHidden = false
        }else {
            btnSwitch.isHidden = true
        }
    }
    
    //MARK:- button actions
    @IBAction func btnActionSwitch(_ sender: AnyObject) {
        if MMUserManager.shared.loggedInUser?.notification == L10n._1.string {
            btnSwitch.setImage(UIImage(asset : .icToggleOff), for: .normal)
            let userData = MMUserManager.shared.loggedInUser
            userData?.notification = L10n._0.string
            MMUserManager.shared.loggedInUser = userData
            configureCell(model: data,row: index)
            ApiManager().getDataOfURL(withApi: API.NotificationOnOff(APIParameters.NotificationOnOff(blockUnblock: L10n.off.string ).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    
                }, method: "POST", loader: false)
            
        }else {
            btnSwitch.setImage(UIImage(asset : .icToggleOn), for: .normal)
            let userData = MMUserManager.shared.loggedInUser
            userData?.notification = L10n._1.string
            MMUserManager.shared.loggedInUser = userData
            configureCell(model: data,row: index)
            ApiManager().getDataOfURL(withApi: API.NotificationOnOff(APIParameters.NotificationOnOff(blockUnblock: L10n.on.string ).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    
                }, method: "POST", loader: false)
            
        }
    }
    
    
}
