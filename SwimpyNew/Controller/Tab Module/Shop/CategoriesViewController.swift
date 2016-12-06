//
//  CategoriesViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CategoriesViewController: UIViewController , IndicatorInfoProvider {
    
    //MARK:- Outlets
    @IBOutlet weak var tableViewCategory: UITableView!
    
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
    
    //MARK:- functions
    func initialize() {
        ApiManager().getDataOfURL(withApi: API.GetCategory(APIParameters.GetCategory().formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                self.arrCategoryData = (model as? [Category]) ?? []
                self.configureTableView()
                print(model)
            }, method: "POST", loader: true)
        
    }
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrCategoryData, height: 112, estimatedHeight: 112, tableView: tableViewCategory, cellIdentifier: CellIdentifiers.CategoryTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? CategoryTableViewCell
            cell?.backgroundColor = UIColor.gray
            cell?.configureCell(model: (self.arrCategoryData[indexpath.row] ))
            }, aRowSelectedListener: {[unowned self] (indexPath) in
                let vc = StoryboardScene.Main.instantiateCategoryProductsViewController()
                vc.categoryId = self.arrCategoryData[indexPath.row].id
                vc.categoryName = self.arrCategoryData[indexPath.row].name ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
        })
        
        tableViewCategory.delegate = tableViewDataSource
        tableViewCategory.dataSource = tableViewDataSource
        tableViewCategory.reloadData()
    }
    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Categories")
    }
    
}
