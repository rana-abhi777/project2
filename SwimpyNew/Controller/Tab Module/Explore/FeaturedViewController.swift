//
//  FeaturedViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FeaturedViewController: BaseViewController,IndicatorInfoProvider {
    
    //MARK:- outlets
    @IBOutlet weak var tableViewFeaturedProducts: UITableView!
    
    
    //MARK:- variables
    var arrFeaturedData : [Products] = []
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
        ApiManager().getDataOfURL(withApi: API.GetFeaturedProduct(APIParameters.GetFeaturedProduct().formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                self.arrFeaturedData = (model as? [Products]) ?? []
                self.configureTableView()
                print(model)
            }, method: "GET", loader: true)
        
    }
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrFeaturedData, height: 616, estimatedHeight: 616, tableView: tableViewFeaturedProducts, cellIdentifier: CellIdentifiers.FeaturedTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? FeaturedTableViewCell
            cell?.configureCell(model: self.arrFeaturedData[indexpath.row])
            }, aRowSelectedListener: { (indexPath) in
               
            })
        
        tableViewFeaturedProducts.delegate = tableViewDataSource
        tableViewFeaturedProducts.dataSource = tableViewDataSource
        tableViewFeaturedProducts.reloadData()
    }

    //MARK:- IndicatorInfoProvider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Featured")
    }
}
