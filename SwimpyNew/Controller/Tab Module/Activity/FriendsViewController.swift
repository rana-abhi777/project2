//
//  FriendsViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/13/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FriendsViewController:  UIViewController,IndicatorInfoProvider  {

    //MARK:- outlets
    @IBOutlet weak var tableViewFriendsActivity: UITableView!
    @IBOutlet weak var viewNoActivity: UIView!
    
    //MARK:- variables
    var arrActivityData : [GlobalActivity] = []
    var tableViewDataSource : TableViewCustomDatasource?
    var pageNo : String?
    let refreshControl = UIRefreshControl()
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNo = L10n._0.string
        refreshControl.addTarget(self, action: #selector(FriendsViewController.setup), for: UIControlEvents.valueChanged)
        tableViewFriendsActivity?.refreshControl =  refreshControl
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:- FUNCTION
    
    func setup() {
        pageNo = L10n._0.string
        arrActivityData = []
        apiToGetFriendsActivity()
    }
    
    func apiToGetFriendsActivity() {
        ApiManager().getDataOfURL(withApi: API.GetFriendsActivity(APIParameters.GetFriendsActivity(pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                
                self.refreshControl.endRefreshing()
                let response = (model as? GlobalActivityData) ?? GlobalActivityData()
                self.pageNo = response.pageNo ?? nil
                for item in response.arrActivity {
                    self.arrActivityData.append(item)
                }
                if self.arrActivityData.count > 0 {
                    self.configureTableView()
                    self.view.bringSubview(toFront: self.tableViewFriendsActivity)
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoActivity)
                }
                
            }, method: Keys.Get.rawValue, loader: true)
        
    }
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrActivityData, height: 89, estimatedHeight: 89, tableView: tableViewFriendsActivity, cellIdentifier: CellIdentifiers.GlobalActivityTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            
            let cell = cell as? GlobalActivityTableViewCell
            cell?.delegate = self
            cell?.configureCell(model: self.arrActivityData[indexpath.row],index : indexpath.row )
            
            }, aRowSelectedListener: { (indexPath) in
                
            }, willDisplayCell: { (indexPath) in
                
                    if let temp = self.pageNo , temp != "" ,indexPath.row == self.arrActivityData.count - 2 {
                            self.apiToGetFriendsActivity()
                    }
        })
        tableViewFriendsActivity.delegate = tableViewDataSource
        tableViewFriendsActivity.dataSource = tableViewDataSource
        tableViewFriendsActivity.reloadData()
    }
    
    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Friends")
    }
}
//MARK:- global activity delegate

extension FriendsViewController : GlobalActivityTask {
    
    func redirectToItemScreen(itemID : String, idType : String) {
        switch idType {
        case Keys.PRODUCT.rawValue :
            let vc = StoryboardScene.Main.instantiateProductDetailViewController()
            vc.productId = itemID
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case Keys.CUSTOMER.rawValue:
            if MMUserManager.shared.loggedInUser?.id == itemID {
                break
            }
            let vc = StoryboardScene.Main.instantiateProfileViewController()
            vc.flagMyProfile = false
            vc.userId = itemID
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case Keys.SELLER.rawValue :
            let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
            vc.sellerId = itemID
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        default:
            print("id type not mentioned")
        }
    }
    func openUserDetail(userID : String) {
        let vc = StoryboardScene.Main.instantiateProfileViewController()
        vc.flagMyProfile = false
        vc.userId = userID
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
