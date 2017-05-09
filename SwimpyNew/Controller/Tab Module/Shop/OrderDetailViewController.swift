//
//  OrderDetailViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/1/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderDetailViewController: BaseViewController {
    
    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- variables
    var tableDataSource : OrderSummaryDataSource? {
        didSet{
            tableView.dataSource = tableDataSource
            tableView.delegate = tableDataSource
        }
    }
    var flagNotAvailable = false
    var arrOrder : [OrderDetail] = []
    var defaultAddress : DefaultAddress?
    var totalAmt : Double?
    var shippingCost : Double?
    
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if flagNotAvailable {
            UserFunctions.showAlert(message : "Some of the products cannot be shipped at you delivery address.are you sure you want to continue")
        }
        configureTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //MARK:- configure tableview and collection view
    func configureTableView() {
        tableDataSource = OrderSummaryDataSource(tableView: tableView, datasource: arrOrder ,address : defaultAddress ,totalAmt : totalAmt,shippingCost : shippingCost,vc: self)
        tableView.reloadData()
    }
    
    
    //MARK:- button action
    @IBAction func btnActionBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension OrderDetailViewController : ProcessOrder {
    
    func generateOrder() {
        
        ApiManager().getDataOfURL(withApi: API.GenerateOrder(APIParameters.GenerateOrder(buyerId: MMUserManager.shared.loggedInUser?.id, addressId: defaultAddress?.id, details: OrderDetail.changeArrayToDict(arrData: arrOrder) as AnyObject, netAmount: "\(/shippingCost + /totalAmt)").formatParameters()), failure: { (err) in
            print(err)
        }, success: {[unowned self] (model) in
            print(model)
         //   UserFunctions.sharedInstance().window?.rootViewController?.stopAnimating()
            self.view.subviews.forEach({ $0.removeFromSuperview() })
            
            //UserFunctions.showAlert(message: "Order placed successfully")
            UserFunctions.showAlert(title: "Successfull!!", message: "Order placed Successfully.", type: "info")
            
            let _ = self.navigationController?.popToRootViewController(animated: true)
            ApiManager.hideLoader()
            }, method: Keys.Post.rawValue, loader: true)
    }
}
