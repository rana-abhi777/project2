//
//  AddressDetailsViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/7/16.
//  Copyright © 2016 Aseem 10. All rights reserved.


import UIKit
import EZSwiftExtensions


class AddressDetailsViewController: BaseViewController {
    
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
    
    @IBOutlet weak var btnCart: UIButton!
    //MARK:- variables
    var flagMarkAsDefault = false
    var defaultAddressData : DefaultAddress?
    var flagEditApi = false
    var arrCartData : [CartData] = []
    var defaultAddress : DefaultAddress?
    var code = "IN"
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCart.isHidden = true
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
                
            }, method: Keys.Get.rawValue, loader: false)
        
    }
    //MARK:-  function
    
    func setUI() {
        txtFullname.text = /defaultAddressData?.fullName
        txtMobileNumber.text = /defaultAddressData?.phoneNo
        txtAddressLine2.text = /defaultAddressData?.addressLine2
        txtAddressLine1.text = /defaultAddressData?.addressLine1
        flagMarkAsDefault = defaultAddressData?.isDefault ?? false
        txtCity.text = /defaultAddressData?.city
        txtZipcode.text = /defaultAddressData?.zipcode
        txtState.text = /defaultAddressData?.state
        code = /defaultAddressData?.countryCode
        //code = "IN"
        if let country = defaultAddressData?.countryName , country != "" {
            lblCountry.text = country
        }
        else {
            lblCountry.text  = L10n.selectCountry.string
        }
        flagMarkAsDefault ? btnMarkAsDefault.setImage(UIImage(asset: .icCheckSmall), for: .normal) : btnMarkAsDefault.setImage(UIImage(asset: .icCheckSmall0), for: .normal)
        guard let id = defaultAddressData?.id , id != ""  else{
            flagEditApi = false
            return
        }
        flagEditApi = true
    }
    
    func validateData() -> Bool {
        
        var indicator = true
        if txtFullname.text?.trimmed().characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterYourFullName.string)
            indicator = false
        }else if (/txtFullname.text).hasSpecialCharcters  {
            UserFunctions.showAlert(message: L10n.enterYourValidName.string)
            indicator = false
        }
        if /txtAddressLine1.text?.trimmed().characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterAddressLine1.string)
            indicator = false
            
        }else if /txtAddressLine2.text?.trimmed().characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterAddressLine2.string)
            indicator = false
            
        }else if /txtCity.text?.trimmed().characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterCity.string)
            indicator = false
            
        }else if /txtState.text?.trimmed().characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterState.string)
            indicator = false
            
        }else if /txtZipcode.text?.trimmed().characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterZipcode.string)
            indicator = false
        }
        else if lblCountry.text  == L10n.selectCountry.string {
            UserFunctions.showAlert(message: L10n.pleaseSelectCountry.string)
            indicator = false
        }else if /txtMobileNumber.text?.trimmed().characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterMobileNumber.string)
            indicator = false
        }
        return indicator
    }
    
    
    func apiToCalculateShipping() {
        ApiManager().getDataOfURL(withApi: API.CalculateShipping(APIParameters.CalculateShipping( details: GenerateOrder.changeDictToModelArray(arrData: arrCartData) as AnyObject?,  countryCode: code).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                guard let response = model as? OrderSummary else { return }
                guard let arrOrder = response.arrOrder  else { return }
                guard let arrNotAvailable = response.arrNotAvailable else { return }
                
                
                print(arrOrder)
                var totalAmt : Double = 0.0
                var shippingCost : Double = 0.0
                
                for item in arrOrder {
                    totalAmt = totalAmt +  (((/item.price).toDouble() ?? 0.0) * (item.quantity?.toDouble() ?? 1.0))
                    shippingCost = shippingCost +
                        (/item.shippingCost).toDouble()!
                }
                
                let VC = StoryboardScene.Main.instantiateOrderDetailViewController()
                if arrNotAvailable.count > 0 {
                    VC.flagNotAvailable = true
                }
                if arrOrder.count > 0 {
                    VC.arrOrder = arrOrder
                    VC.defaultAddress = self.defaultAddress
                    VC.totalAmt = totalAmt
                    VC.shippingCost = shippingCost
                    self.navigationController?.pushViewController(VC, animated: true)
                }else {
                    UserFunctions.showAlert(message: "Product cannot be delivered at your address")
                }
            }, method: Keys.Post.rawValue, loader: true)
        
        
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
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionSave(sender: AnyObject) {
        if validateData() {
            var api : API?
            if flagEditApi {
                api = API.EditAddress(APIParameters.EditAddress(addressId : defaultAddressData?.id , fullName: txtFullname.text, addressLine1: txtAddressLine1.text, addressLine2: txtAddressLine2.text, countryName: lblCountry.text, city: txtCity.text, state: txtState.text, zipcode: txtZipcode.text, phoneNo: txtMobileNumber.text,isDefault : "\(flagMarkAsDefault)", countryCode : code).formatParameters())
            }
            else {
                api = API.AddAddress(APIParameters.AddAddress(fullName: txtFullname.text, addressLine1: txtAddressLine1.text, addressLine2: txtAddressLine2.text, countryName: lblCountry.text, city: txtCity.text, state: txtState.text, zipcode: txtZipcode.text, phoneNo: txtMobileNumber.text,isDefault : "\(flagMarkAsDefault)", countryCode : code).formatParameters())
            }
            guard let apiObj = api else {return }
            ApiManager().getDataOfURL(withApi: apiObj, failure: { (err) in
                print(err)
                }, success: { [unowned self] (model) in
                    
                    
                    self.defaultAddress = model as? DefaultAddress
                    self.apiToCalculateShipping()
                    // VC.shippingCost = shippingCost
                    // self.navigationController?.pushViewController(VC, animated: true)
                    // UserFunctions.showAlert(title : L10n.success.string ,message: L10n.addressEditedSuccessfully.string)
                }, method: "POST", loader: true)
            
        }
    }
    
    
    @IBAction func btnActionCountryDropDown(_ sender: AnyObject) {
        let vc = StoryboardScene.Main.instantiateCountryPickerViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension AddressDetailsViewController : SendData {
    func setCountryCode(name : String ,code : String) {
        lblCountry.text = name
        self.code = code
    }
}

