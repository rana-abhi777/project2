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
    var pageNo : String?
  
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pageNo = "0"
        arrFeaturedData = []
        initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- FUNCTION
    func initialize() {
        ApiManager().getDataOfURL(withApi: API.GetFeaturedProduct(APIParameters.GetFeaturedProduct(pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                let response = model as? ProductResponse ?? ProductResponse()
                self.pageNo = response.pageNo ?? nil
                for item in response.arrProducts {
                    self.arrFeaturedData.append(item)
                }
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
//                let productId = self.arrFeaturedData[indexPath.row].id ?? ""
//                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
//                vc.productId = productId
//                self.navigationController?.pushViewController(vc, animated: true)
            }, willDisplayCell: {[unowned self] (indexPath) in
                if indexPath.row == self.arrFeaturedData.count - 2 {
                    if let temp = self.pageNo  {
                        if temp != "" {
                            self.initialize()
                        }
                    }
                    
                }
        })
        
        tableViewFeaturedProducts.delegate = tableViewDataSource
        tableViewFeaturedProducts.dataSource = tableViewDataSource
        tableViewFeaturedProducts.reloadData()
    }
    
    func updateLikeData(model : Products?,index : Int) {
        arrFeaturedData[index] = model ?? Products()
        configureTableView()
    }
    func cellSelected(index : Int ) {
        let productId = self.arrFeaturedData[index].id ?? ""
        let vc = StoryboardScene.Main.instantiateProductDetailViewController()
        vc.productId = productId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK:- IndicatorInfoProvider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Featured")
    }
}
