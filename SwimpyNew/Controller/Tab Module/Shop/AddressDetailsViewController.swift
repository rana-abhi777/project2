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
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtZipcode: UITextField!
    
    //MARK:- variables
    var flagMarkAsDefault = false
    
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
        if flagMarkAsDefault {
            btnMarkAsDefault.setImage(UIImage(asset: .icCheckSmall), for: .normal)
            flagMarkAsDefault = false
        }
        else {
            btnMarkAsDefault.setImage(UIImage(asset: .icCheckSmall0), for: .normal)
            flagMarkAsDefault = true
        }
    }
    
    @IBAction func btnActionBack(sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionCancel(sender: AnyObject) {
    }
    @IBAction func btnActionSave(sender: AnyObject) {
        ApiManager().getDataOfURL(withApi: API.AddAddress(APIParameters.AddAddress(fullName: txtFullname.text, addressLine1: txtAddressLine1.text, addressLine2: txtAddressLine2.text, countryName: lblCountry.text, city: txtCity.text, state: txtState.text, zipcode: txtZipcode.text, phoneNo: txtMobileNumber.text,isDefault : flagMarkAsDefault).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                print(model)
            }, method: "POST", loader: true)
    }
    
    
    @IBAction func btnActionCountryDropDown(_ sender: AnyObject) {
    }
    
}
