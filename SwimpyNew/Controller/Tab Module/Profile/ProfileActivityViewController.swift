//
//  ProfileActivityViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileActivityViewController: BaseViewController,IndicatorInfoProvider,GlobalActivityTask {
   
    //MARK:- Outlet
    @IBOutlet weak var tableViewUserActivity: UITableView!
    @IBOutlet weak var viewNoActivity: UIView!
    //MARK:- variables
    var arrActivityData : [GlobalActivity] = []
    var tableViewDataSource : TableViewCustomDatasource?
    var pageNo : String?
    let refreshControl = UIRefreshControl()
    var userId = ""
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNo = "0"
        refreshControl.addTarget(self, action: #selector(ProfileActivityViewController.initialize), for: UIControlEvents.valueChanged)
        tableViewUserActivity?.refreshControl =  refreshControl
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- FUNCTION
    func initialize() {
        pageNo = "0"
        arrActivityData = []
        apiToGetGlobalActivity()
    }
    
    
    func apiToGetGlobalActivity() {
        ApiManager().getDataOfURL(withApi: API.GetUserActivity(APIParameters.GetUserActivity(pageNo : pageNo).formatParameters()), failure: { (err) in
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
                    self.view.bringSubview(toFront: self.tableViewUserActivity)
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoActivity)
                    
                }
            }, method: "GET", loader: true)
    }
    
    func redirectToItemScreen(itemID : String, idType : String) {
        switch idType {
        case "PRODUCT" :
            let vc = StoryboardScene.Main.instantiateProductDetailViewController()
            vc.productId = itemID
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "CUSTOMER":
            let vc = StoryboardScene.Main.instantiateProfileViewController()
            vc.flagMyProfile = false
            vc.userId = itemID
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
            print("customer page not ready")
            break
        case "SELLER" :
            let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
            vc.sellerId = itemID
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        default:
            print("id type not mentioned")
        }
    }
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrActivityData, height: 89, estimatedHeight: 89, tableView: tableViewUserActivity, cellIdentifier: CellIdentifiers.GlobalActivityTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? GlobalActivityTableViewCell
            cell?.delegate = self
            cell?.configureCell(model: self.arrActivityData[indexpath.row],index : indexpath.row )
            }, aRowSelectedListener: { (indexPath) in
            }, willDisplayCell: { (indexPath) in
                if indexPath.row == self.arrActivityData.count - 2 {
                    if let temp = self.pageNo  {
                        if temp != "" {
                            self.apiToGetGlobalActivity()
                        }
                    }
                    
                }
        })
        tableViewUserActivity.delegate = tableViewDataSource
        tableViewUserActivity.dataSource = tableViewDataSource
        tableViewUserActivity.reloadData()
    }
    
    func openUserDetail(userID : String) {
        let vc = StoryboardScene.Main.instantiateProfileViewController()
        vc.flagMyProfile = false
        vc.userId = userID
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK:- IndicatorInfoProvider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Activity")
    }

}
