//
//  CartViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/7/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var tableViewCart: UITableView!
    @IBOutlet weak var viewNoItems: UIView!
    @IBOutlet weak var viewSoldOut: UIView!
    @IBOutlet weak var lblProductSoldOut: UILabel!
    //MARK:- variables
    var tableDataSource : CartDataSource? {
        didSet{
            tableViewCart.dataSource = tableDataSource
            tableViewCart.delegate = tableDataSource
        }
    }
    var arrCartData : [CartData] = []
    var productDetails: ProductDetail?
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialize()
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
            if self.arrCartData.count > 0 {
                self.configureTableView()
                self.view.bringSubview(toFront: self.tableViewCart)
            }
            else {
                self.view.bringSubview(toFront: self.viewNoItems)
            }
            
            }, method: Keys.Post.rawValue, loader: true)
    }
    
    
    //MARK:- configure tableview and collection view
    func configureTableView() {
        tableDataSource = CartDataSource(tableView: tableViewCart, datasource: arrCartData ,vc: self)
        tableViewCart.reloadData()
    }
    
    //MARK:- button actions
    @IBAction func btnActionBack(sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- CartProductTask delegate function
extension CartViewController : CartProductTask{
    
    func updateQuantity(model : CartData?,index: Int) {
        guard let temp = model else { return }
        arrCartData[index] = temp
        configureTableView()
    }
    
    func removeProductFromCart(index: Int) {
        
        ApiManager().getDataOfURL(withApi: API.RemoveCartItem(APIParameters.RemoveCartItem(cartId: arrCartData[index].cartId).formatParameters()), failure: { (err) in
            print(err)
            
        }, success: {[unowned self] (model) in
            self.hitApiToGetCartDetails()
            self.configureTableView()
            
            }, method: Keys.Put.rawValue, loader: true)
    }
}

//MARK:- CartTask delegate function
extension CartViewController : CartTask{
    
    func nextStep() {
        let VC = StoryboardScene.Main.instantiateAddressDetailsViewController()
        VC.arrCartData = arrCartData
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}
