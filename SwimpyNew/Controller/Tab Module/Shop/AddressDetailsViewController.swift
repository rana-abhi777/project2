//
//  AddressDetailsViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/7/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import MICountryPicker

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
    var defaultAddressData : DefaultAddress?
    var flagEditApi = false
    
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        hitApiToGetAddress()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func hitApiToGetAddress() {
        ApiManager().getDataOfURL(withApi: API.GetAddress(APIParameters.GetAddress().formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                //fill the fields
                self.defaultAddressData = model as? DefaultAddress
                self.setUI()
                
            }, method: "GET", loader: true)
        
    }
    //MARK:-  function
    
    func setUI() {
        txtFullname.text = defaultAddressData?.fullName ?? ""
        txtMobileNumber.text = defaultAddressData?.phoneNo ?? ""
        txtAddressLine2.text = defaultAddressData?.addressLine2 ?? ""
        txtAddressLine1.text = defaultAddressData?.addressLine1 ?? ""
        flagMarkAsDefault = defaultAddressData?.isDefault ?? false
        txtCity.text = defaultAddressData?.city ?? ""
        txtZipcode.text = defaultAddressData?.zipcode ?? ""
        txtState.text = defaultAddressData?.state ?? ""
        lblCountry.text = defaultAddressData?.countryName ?? L10n.selectCountry.string
        flagMarkAsDefault ? btnMarkAsDefault.setImage(UIImage(asset: .icCheckSmall), for: .normal) : btnMarkAsDefault.setImage(UIImage(asset: .icCheckSmall0), for: .normal)
        guard let _ = defaultAddressData?.id else{
            flagEditApi = false
            return
        }
        flagEditApi = true
    }
    
    func validateData() -> Bool {
        var indicator = true
        if lblCountry.text  == L10n.selectCountry.string {
            UserFunctions.showAlert(message: L10n.pleaseSelectCountry.string)
            indicator = false
        }
        return indicator
    }
    
    //MARK:- button actions
    
    @IBAction func btnActionMarkAsDefault(sender: AnyObject) {
        if flagMarkAsDefault {
            btnMarkAsDefault.setImage(UIImage(asset: .icCheckSmall0), for: .normal)
            flagMarkAsDefault = false
        }
        else {
            btnMarkAsDefault.setImage(UIImage(asset: .icCheckSmall), for: .normal)
            flagMarkAsDefault = true
        }
    }
    
    @IBAction func btnActionBack(sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionCancel(sender: AnyObject) {
    }
    
    @IBAction func btnActionSave(sender: AnyObject) {
        if validateData() {
            if flagEditApi {
                ApiManager().getDataOfURL(withApi: API.EditAddress(APIParameters.EditAddress(fullName: txtFullname.text, addressLine1: txtAddressLine1.text, addressLine2: txtAddressLine2.text, countryName: lblCountry.text, city: txtCity.text, state: txtState.text, zipcode: txtZipcode.text, phoneNo: txtMobileNumber.text,isDefault : "\(flagMarkAsDefault)",addressId : defaultAddressData?.id).formatParameters()), failure: { (err) in
                    print(err)
                    }, success: { (model) in
                        UserFunctions.showAlert(title : L10n.success.string ,message: L10n.addressEditedSuccessfully.string)
                    }, method: "POST", loader: true)
            }
            else {
                ApiManager().getDataOfURL(withApi: API.AddAddress(APIParameters.AddAddress(fullName: txtFullname.text, addressLine1: txtAddressLine1.text, addressLine2: txtAddressLine2.text, countryName: lblCountry.text, city: txtCity.text, state: txtState.text, zipcode: txtZipcode.text, phoneNo: txtMobileNumber.text,isDefault : "\(flagMarkAsDefault)").formatParameters()), failure: { (err) in
                    print(err)
                    }, success: { (model) in
                        UserFunctions.showAlert(title : L10n.success.string ,message: L10n.addressAddedSuccessfully.string)
                    }, method: "POST", loader: true)
            }
        }
    }
    
    
    @IBAction func btnActionCountryDropDown(_ sender: AnyObject) {
        let picker = MICountryPicker()
        picker.delegate = self
        navigationController?.pushViewController(picker, animated: false)
    }
    
}


extension AddressDetailsViewController : MICountryPickerDelegate {
    public func countryPicker(_ picker: MICountryPicker, didSelectCountryWithName name: String, code: String) {
        lblCountry.text = name
        _ = navigationController?.popViewController(animated: false)
    }
    
    func countryPicker(_ picker: MICountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        //
    }
}
