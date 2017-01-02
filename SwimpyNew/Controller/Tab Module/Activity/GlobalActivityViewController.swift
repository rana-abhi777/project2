//
//  GlobalActivityViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class GlobalActivityViewController: UIViewController,IndicatorInfoProvider,GlobalActivityTask {
    
    //MARK:- outlets
    @IBOutlet weak var tableViewGlobalActivity: UITableView!
    
    //MARK:- variables
    var arrActivityData : [GlobalActivity] = []
    var tableViewDataSource : TableViewCustomDatasource?
    var pageNo : String?
    let refreshControl = UIRefreshControl()
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNo = "0"
        refreshControl.addTarget(self, action: #selector(GlobalActivityViewController.initialize), for: UIControlEvents.valueChanged)
        tableViewGlobalActivity?.refreshControl =  refreshControl
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
        ApiManager().getDataOfURL(withApi: API.GetGlobalActivity(APIParameters.GetGlobalActivity(pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.refreshControl.endRefreshing()
                let response = (model as? GlobalActivityData) ?? GlobalActivityData()
                self.pageNo = response.pageNo ?? nil
                for item in response.arrActivity {
                    self.arrActivityData.append(item)
                }
                self.configureTableView()
            }, method: "GET", loader: true)
        
    }
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrActivityData, height: 89, estimatedHeight: 89, tableView: tableViewGlobalActivity, cellIdentifier: CellIdentifiers.GlobalActivityTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
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
        tableViewGlobalActivity.delegate = tableViewDataSource
        tableViewGlobalActivity.dataSource = tableViewDataSource
        tableViewGlobalActivity.reloadData()
    }
    
    //MARK:- global activity delegate
    func redirectToItemScreen(itemID : String, idType : String) {
        switch idType {
        case "PRODUCT" :
            let vc = StoryboardScene.Main.instantiateProductDetailViewController()
            vc.productId = itemID
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "CUSTOMER":
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
    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Global")
    }
    
    
}
