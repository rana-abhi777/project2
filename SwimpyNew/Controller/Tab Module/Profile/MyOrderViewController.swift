//
//  MyOrderViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/30/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class MyOrderViewController: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var tableViewOrder: UITableView!
    @IBOutlet weak var viewNoOrder: UIView!
    
    //MARK:- variables
    var arrOrderList : [MyOrderList] = []
    var tableViewDataSource : TableViewCustomDatasource?
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        myOrdersApi()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- function
    func myOrdersApi() {
        ApiManager().getDataOfURL(withApi: API.MyOrderList(APIParameters.MyOrderList().formatParameters()), failure: { (err) in
            print(err)
        }, success: { [unowned self] (model) in
            self.arrOrderList = model as? [MyOrderList] ?? []
            if self.arrOrderList.count > 0 {
                self.view.bringSubview(toFront: self.tableViewOrder)
                self.configureTableView()
            }else {
                self.view.bringSubview(toFront: self.viewNoOrder)
            }
            }, method: Keys.Get.rawValue, loader: true)
    }
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrOrderList, height: UITableViewAutomaticDimension, estimatedHeight: 231, tableView: tableViewOrder, cellIdentifier: CellIdentifiers.MyOrderTableViewCell.rawValue, configureCellBlock:
            {[unowned self] (cell, item, indexpath) in
                let cell = cell as? MyOrderTableViewCell
                cell?.delegate = self
                cell?.configureCell(model: self.arrOrderList[indexpath.row],index : indexpath.row )
            }, aRowSelectedListener: { (indexPath) in
        }, willDisplayCell: { (indexPath) in
        })
        tableViewOrder.delegate = tableViewDataSource
        tableViewOrder.dataSource = tableViewDataSource
        tableViewOrder.reloadData()
    }
    
    //MARK:- button actions
    @IBAction func btnActionBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- DELEGATE FUNCTION
extension MyOrderViewController : MyOrderTask {
    
    func cancelOrder(index: Int) {
        ApiManager().getDataOfURL(withApi: API.CancelOrder(APIParameters.CancelOrder(orderId: self.arrOrderList[index].orderId, detailId: self.arrOrderList[index].detailsId).formatParameters()), failure: { (err) in
            print(err)
        }, success: { [unowned self] (model) in
            self.myOrdersApi()
            }, method: Keys.Put.rawValue, loader: true)
    }
    
    func openDetails(productId : String?) {
        let VC = StoryboardScene.Main.instantiateProductDetailViewController()
        VC.productId = /productId
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}
