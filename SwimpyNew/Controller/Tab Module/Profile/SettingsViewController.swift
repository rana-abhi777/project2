//
//  SettingsViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/5/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var tableViewSettings: UITableView!
    
    //MARK:- variables
    var arrData : [String] = [L10n.editProfile.string,L10n.myOrders.string,L10n.termsAndConditions.string,L10n.notifications.string,L10n.changePassword.string,L10n.logout.string]
    var tableViewDataSource : TableViewCustomDatasource?
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- functions
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrData as Array<AnyObject>?, height: 56, estimatedHeight: 56, tableView: tableViewSettings, cellIdentifier: CellIdentifiers.SettingsTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? SettingsTableViewCell
            cell?.configureCell(model: self.arrData[indexpath.row] ,row: indexpath.row)
            }, aRowSelectedListener: {[unowned self] (indexPath) in
                switch indexPath.row {
                case SwitchValues.zero.rawValue: //edit profile
                    let VC = StoryboardScene.Main.instantiateEditProfileViewController()
                    self.navigationController?.pushViewController(VC, animated: true)
                    break
                case SwitchValues.one.rawValue: //edit profile
                    let VC = StoryboardScene.Main.instantiateMyOrderViewController()
                    self.navigationController?.pushViewController(VC, animated: true)
                    break
                case SwitchValues.four.rawValue: //change password
                    let VC = StoryboardScene.Main.instantiateChangePasswordViewController()
                    self.navigationController?.pushViewController(VC, animated: true)
                    break
                case SwitchValues.five.rawValue: //logout
                    let alert = UIAlertController(title: L10n.logout.string, message: L10n.areYouSure.string, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: L10n.cancel.string, style: .default, handler: { (action) in
                       
                    }))
                    alert.addAction(UIAlertAction(title: L10n.ok.string, style: .default, handler: { (action) in
                       self.logout()
                    }))

                    self.present(alert, animated: true, completion: nil)
                    
                default :
                    break
                }
                
            }, willDisplayCell: { (indexPath) in
        })
        
        tableViewSettings.delegate = tableViewDataSource
        tableViewSettings.dataSource = tableViewDataSource
        tableViewSettings.reloadData()
    }
    
    func logout() {
        
        
        ApiManager().getDataOfURL(withApi: API.Logout(APIParameters.Logout( ).formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                UserDefaults.standard.removeObject(forKey: "SwimpyUser")
                let initialNavVC = StoryboardScene.Main.instantiateInitialNavigationViewController()
                let VC = StoryboardScene.Main.instantiateLoginViewController()
                initialNavVC.viewControllers = [VC]
                UserFunctions.sharedInstance().window?.rootViewController = initialNavVC

            }, method: Keys.Put.rawValue, loader: true)
    }
    
    //MARK:- button action
    @IBAction func btnActionBack(_ sender: AnyObject) {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
}
