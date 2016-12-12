//
//  GlobalActivityViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class GlobalActivityViewController: UIViewController,IndicatorInfoProvider {
    
    //MARK:- outlets
    @IBOutlet weak var tableViewGlobalActivity: UITableView!
    
    //MARK:- variables
    var arrCategoryData : [Category] = []
    var tableViewDataSource : TableViewCustomDatasource?
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:- FUNCTION
    func initialize() {
        ApiManager().getDataOfURL(withApi: API.GetGlobalActivity(APIParameters.GetGlobalActivity().formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                self.arrCategoryData = (model as? [GlobalActivity]) ?? []
//                self.configureTableView()
                print(model)
            }, method: "POST", loader: true)
        
    }
    
//    func configureTableView() {
//        tableViewDataSource = TableViewCustomDatasource(items: arrCategoryData, height: 112, estimatedHeight: 112, tableView: tableViewGlobalActivity, cellIdentifier: CellIdentifiers.CategoryTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
//            let cell = cell as? CategoryTableViewCell
//            cell?.backgroundColor = UIColor.gray
//            cell?.configureCell(model: (self.arrCategoryData[indexpath.row] ))
//            }, aRowSelectedListener: {[unowned self] (indexPath) in
//                let vc = StoryboardScene.Main.instantiateCategoryProductsViewController()
//                vc.categoryId = self.arrCategoryData[indexPath.row].id
//                vc.categoryName = self.arrCategoryData[indexPath.row].name ?? ""
//                self.navigationController?.pushViewController(vc, animated: true)
//            })
//        
//        tableViewGlobalActivity.delegate = tableViewDataSource
//        tableViewGlobalActivity.dataSource = tableViewDataSource
//        tableViewGlobalActivity.reloadData()
//    }
//
    
    
    
    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Global")
    }
    
    
}
