//
//  ChangePasswordViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/9/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    
    @IBOutlet weak var txtOldPassword: UITextField!
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- function
    func validateChangePassword() -> Bool {
        var indicator = true
        if (/txtOldPassword.text ).characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterOldPassword.string)
            indicator = false
        }

       else if (/txtNewPassword.text ).characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterPassword.string)
            indicator = false
        }
        else if (/txtNewPassword.text ).characters.count < 6 {
            UserFunctions.showAlert(message: L10n.passwordLengthShouldBeAtleast6Characters.string)
            indicator = false
        }
        else if (/txtConfirmPassword.text ).characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterConfirmPassword.string)
            indicator = false
        }
        else if txtConfirmPassword.text  != txtNewPassword.text {
            UserFunctions.showAlert(message: L10n.newPasswordShouldBeSameAsConfirmPassword.string)
            indicator = false
        }
         view.isUserInteractionEnabled = true
        return indicator
    }
    
    
    //MARK:- button action
    @IBAction func btnActionSubmit(_ sender: AnyObject) {
        view.endEditing(true)
        view.isUserInteractionEnabled = false
        if validateChangePassword() {
             view.isUserInteractionEnabled = true
            ApiManager().getDataOfURL(withApi: API.ChangePassword(APIParameters.ChangePassword(newPassword: txtNewPassword.text , oldPassword : txtOldPassword.text ).formatParameters()), failure: { (err) in
                print(err)
                
                }, success: { (model) in
                    UserFunctions.showAlert(title: L10n.success.string, message: L10n.passwordUpdatedSuccessfully.string)
                    self.viewDidLoad()
                }, method: Keys.Put.rawValue, loader: true)
        }
    }
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        _ =  self.navigationController?.popViewController(animated: true)
    }
    
}
