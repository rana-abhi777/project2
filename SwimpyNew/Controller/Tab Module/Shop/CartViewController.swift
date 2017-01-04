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
    
    //MARK:- variables
    var productDetail : ProductDetail?
    var tableDataSource : CartDataSource? {
        didSet{
            tableViewCart.dataSource = tableDataSource
            tableViewCart.delegate = tableDataSource
        }
    }
   
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- CartProductTask delegate function
    
    func updateQuantity(model : ProductDetail?) {
        productDetail = model
        configureTableView()
    }
    
    func gotoPreviousScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- configure tableview and collection view
    func configureTableView() {
        
        tableDataSource = CartDataSource(tableView: tableViewCart, datasource: productDetail ?? ProductDetail(),vc: self)
        tableViewCart.reloadData()
    }
    
    //MARK:- button actions
    @IBAction func btnActionBack(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}
