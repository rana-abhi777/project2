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
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- function
    func validateChangePassword() -> Bool {
        var indicator = true
        
        let trimmedPassword = ValidateData().trimmedString(string: txtNewPassword.text ?? "")
        if trimmedPassword.characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterPassword.string)
            indicator = false
        }
        if trimmedPassword.characters.count < 6 {
            UserFunctions.showAlert(message: L10n.passwordLengthShouldBeAtleast6Characters.string)
            indicator = false
        }
        let trimmedSamePassword = ValidateData().trimmedString(string: txtConfirmPassword.text ?? "")
        if trimmedSamePassword.characters.count == 0 {
            UserFunctions.showAlert(message: L10n.enterConfirmPassword.string)
            indicator = false
        }
        if trimmedPassword != trimmedSamePassword {
            UserFunctions.showAlert(message: L10n.newPasswordShouldBeSameAsConfirmPassword.string)
            indicator = false
        }
        return indicator
    }
    
    
    //MARK:- button action
    @IBAction func btnActionSubmit(_ sender: AnyObject) {
        if validateChangePassword() {
            //hit api
            ApiManager().getDataOfURL(withApi: API.ChangePassword(APIParameters.ChangePassword(newPassword: txtNewPassword.text ).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                    UserFunctions.showAlert(title: "Success", message: "Password updated successfully", success: { 
                        self.navigationController?.popViewController(animated: true)
                    })
                   
                }, method: "PUT", loader: false)
        }
    }
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
