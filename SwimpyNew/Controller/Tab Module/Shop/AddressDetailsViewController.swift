//
//  AddressDetailsViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/7/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class AddressDetailsViewController: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var btnMarkAsDefault: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtAddressLine2: UITextField!
    @IBOutlet weak var txtAddressLine1: UITextField!
    @IBOutlet weak var txtFullname: UITextField!
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:- button actions
    @IBAction func btnActionMarkAsDefault(sender: AnyObject) {
        //ic_check_small
    }
    
    @IBAction func btnActionBack(sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionCancel(sender: AnyObject) {
    }
    @IBAction func btnActionSave(sender: AnyObject) {
    }
}
