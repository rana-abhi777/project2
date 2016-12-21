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
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initialize()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:- FUNCTION
    func initialize() {
        ApiManager().getDataOfURL(withApi: API.GetGlobalActivity(APIParameters.GetGlobalActivity().formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.arrActivityData = (model as? [GlobalActivity]) ?? []
                self.configureTableView()
                print(model)
            }, method: "GET", loader: true)
        
    }
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrActivityData, height: 89, estimatedHeight: 89, tableView: tableViewGlobalActivity, cellIdentifier: CellIdentifiers.GlobalActivityTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? GlobalActivityTableViewCell
            cell?.configureCell(model: self.arrActivityData[indexpath.row],index : indexpath.row )
            }, aRowSelectedListener: { (indexPath) in
            })
        
        tableViewGlobalActivity.delegate = tableViewDataSource
        tableViewGlobalActivity.dataSource = tableViewDataSource
        tableViewGlobalActivity.reloadData()
    }
    
    //MARK:- global activity delegate
    func redirectToItemScreen(idType : String, itemID : String) {
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
            print("seller page not ready")
        let vc = StoryboardScene.Main.storeProfileViewControllerScene
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
