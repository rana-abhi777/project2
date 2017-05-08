//
//  ProfileActivityViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileActivityViewController: BaseViewController,IndicatorInfoProvider {
    
    //MARK:- Outlet
    @IBOutlet weak var tableViewUserActivity: UITableView!
    @IBOutlet weak var viewNoActivity: UIView!
    //MARK:- variables
    var arrActivityData : [GlobalActivity] = []
    var tableViewDataSource : TableViewCustomDatasource?
    var pageNo : String?
    var userId = ""
    var refreshControl = UIRefreshControl()
    var isLoadMore = false
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handlePagination()
        refreshControl = UIRefreshControl(superView: tableViewUserActivity)
        refreshControl.addTarget(self, action: #selector(ProfileActivityViewController.setup), for: UIControlEvents.valueChanged)
        tableViewUserActivity?.refreshControl =  refreshControl
       // setup()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        
//    }
    override func viewDidAppear(_ animated: Bool) {
        setup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- FUNCTION
    func resetNoMoreData(){
        self.tableViewUserActivity.es_resetNoMoreData()
    }
    
    func foundNoMoreData(){
        self.tableViewUserActivity.es_stopLoadingMore()
        self.tableViewUserActivity.es_noticeNoMoreData()
    }
    
    func handlePagination(){
        let _ = tableViewUserActivity.es_addInfiniteScrolling { [unowned self] in
            if self.pageNo != "" {
                self.apiToGetGlobalActivity()
            }else{
                self.foundNoMoreData()
            }
        }
    }

    func setup() {
        pageNo = L10n._0.string
        arrActivityData = []
        configureTableView()
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
                
                self.isLoadMore = response.arrActivity.count > 0
                self.tableViewUserActivity.es_stopLoadingMore()
                self.isLoadMore ? self.tableViewUserActivity.es_resetNoMoreData() : self.tableViewUserActivity.es_noticeNoMoreData()
                
                
                self.refreshControl.endRefreshing()
                if self.arrActivityData.count > 0 {
                    self.configureTableView()
                    self.view.bringSubview(toFront: self.tableViewUserActivity)
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoActivity)
                    
                }
                
            }, method: Keys.Get.rawValue, loader: true)
    }
    
    
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrActivityData, height: 89, estimatedHeight: 89, tableView: tableViewUserActivity, cellIdentifier: CellIdentifiers.GlobalActivityTableViewCell.rawValue, configureCellBlock:
            {[unowned self] (cell, item, indexpath) in
                
            let cell = cell as? GlobalActivityTableViewCell
            cell?.delegate = self
            cell?.configureCell(model: self.arrActivityData[indexpath.row],index : indexpath.row )
            
            }, aRowSelectedListener: { (indexPath) in
                
            }, willDisplayCell: { (indexPath) in
                    if let temp = self.pageNo, temp != "",indexPath.row == self.arrActivityData.count - 2  {
                        self.apiToGetGlobalActivity()
                    }
        })
        tableViewUserActivity.delegate = tableViewDataSource
        tableViewUserActivity.dataSource = tableViewDataSource
        tableViewUserActivity.reloadData()
    }
    
    
    
    //MARK:- IndicatorInfoProvider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Activity")
    }
    
}

//MARK: - DELEGATE FUNCTION
extension ProfileActivityViewController : GlobalActivityTask {
    
    func redirectToItemScreen(itemID : String, idType : String) {
        switch idType {
        case Keys.PRODUCT.rawValue :
            let vc = StoryboardScene.Main.instantiateProductDetailViewController()
            vc.productId = itemID
            self.navigationController?.pushViewController(vc, animated: true)
            
        case Keys.CUSTOMER.rawValue:
            let vc = StoryboardScene.Main.instantiateProfileViewController()
            vc.flagMyProfile = false
            vc.userId = itemID
            self.navigationController?.pushViewController(vc, animated: true)
           
        case Keys.SELLER.rawValue :
            let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
            vc.sellerId = itemID
            self.navigationController?.pushViewController(vc, animated: true)
            
            
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
