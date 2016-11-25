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
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- button actions
    @IBAction func btnActionBack(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}
