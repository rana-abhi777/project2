//
//  FeaturedViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FeaturedViewController: BaseViewController,IndicatorInfoProvider,FeaturedProductsTask {
    
    //MARK:- outlets
    @IBOutlet weak var tableViewFeaturedProducts: UITableView!
    
    
    //MARK:- variables
    var arrFeaturedData : [Products] = []
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
        ApiManager().getDataOfURL(withApi: API.GetFeaturedProduct(APIParameters.GetFeaturedProduct().formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                self.arrFeaturedData = (model as? [Products]) ?? []
                self.configureTableView()
                print(model)
            }, method: "GET", loader: true)
        
    }
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrFeaturedData, height: 310, estimatedHeight: 310, tableView: tableViewFeaturedProducts, cellIdentifier: CellIdentifiers.FeaturedTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? FeaturedTableViewCell
            cell?.delegate = self
            cell?.configureCell(model: self.arrFeaturedData[indexpath.row],row : indexpath.row)
            }, aRowSelectedListener: { (indexPath) in
                let productId = self.arrFeaturedData[indexPath.row].id ?? ""
                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
                vc.productId = productId
                self.navigationController?.pushViewController(vc, animated: true)
            })
        
        tableViewFeaturedProducts.delegate = tableViewDataSource
        tableViewFeaturedProducts.dataSource = tableViewDataSource
        tableViewFeaturedProducts.reloadData()
    }
    
    func updateLikeData(model : Products?,index : Int) {
        arrFeaturedData[index] = model ?? Products()
        configureTableView()
    }

    //MARK:- IndicatorInfoProvider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Featured")
    }
}
