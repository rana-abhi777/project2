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
        tableViewDataSource = TableViewCustomDatasource(items: arrActivityData, height: 89, estimatedHeight: 89, tableView: tableViewUserActivity, cellIdentifier: CellIdentifiers.GlobalActivityTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? GlobalActivityTableViewCell
            cell?.configureCell(model: self.arrActivityData[indexpath.row],index : indexpath.row )
            }, aRowSelectedListener: { (indexPath) in
            }, willDisplayCell: { (indexPath) in
                
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
