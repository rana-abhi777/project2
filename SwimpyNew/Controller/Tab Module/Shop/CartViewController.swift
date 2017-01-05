//
//  CartViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/7/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class CartViewController: UIViewController,CartProductTask {
    
    //MARK:- outlets
    @IBOutlet weak var tableViewCart: UITableView!
    @IBOutlet weak var viewNoItems: UIView!
    //MARK:- variables
    var tableDataSource : CartDataSource? {
        didSet{
            tableViewCart.dataSource = tableDataSource
            tableViewCart.delegate = tableDataSource
        }
    }
    var arrCartData : [CartData] = []
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        configureTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- function
     
    func initialize() {
        hitApiToGetCartDetails()
    }
    
    func hitApiToGetCartDetails() {
        ApiManager().getDataOfURL(withApi: API.GetCartDetail(APIParameters.GetCartDetail().formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.arrCartData = (model as? [CartData]) ?? []
                self.configureTableView()
                print(model)
            }, method: "POST", loader: true)
    }
    
    //MARK:- CartProductTask delegate function
    
    func updateQuantity(model : CartData?,index: Int) {
        arrCartData[index] = model ?? CartData()
        configureTableView()
    }
    
    func removeProductFromCart(index: Int) {
        ApiManager().getDataOfURL(withApi: API.RemoveCartItem(APIParameters.RemoveCartItem(cartId: arrCartData[index].cartId).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.hitApiToGetCartDetails()
                self.configureTableView()
                print(model)
            }, method: "PUT", loader: true)
    }
    
    //MARK:- configure tableview and collection view
    func configureTableView() {
        tableDataSource = CartDataSource(tableView: tableViewCart, datasource: arrCartData ,vc: self)
        tableViewCart.reloadData()
    }
    
    //MARK:- button actions
    @IBAction func btnActionBack(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}
