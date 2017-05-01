//
//  BaseViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//
import UIKit
import Fusuma
import Presentr
import EZSwiftExtensions
import SwiftyJSON
import MIBadgeButton_Swift

class BaseViewController: UIViewController{
    
    //MARK:- VARIABLE
    let overlayObj = LoadingOverlay()
    var selectedImage : UIImage?
    var btnOutlet : UIButton!
    var btnCartBadge : MIBadgeButton!
    var countryName : String = ""
    var btnCountry : UIButton?
    var lblCountryName : UILabel?
    var txtField: UITextField?
    var imageButton: UIButton!
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK::- CUSTOM PRESENTER
    
    let presenter: Presentr = {
        let width = ModalSize.default
        let height = ModalSize.default
        let center = ModalCenterPosition.center
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVertical
        customPresenter.roundCorners = true
        return customPresenter
    }()
    
    func removeAnimate(view:UIView){
        UIView.animate(withDuration: 1.0, animations: {
            view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            //view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            view.isHidden = true
        })
    }
    
    func showAnimate(view:UIView){
        view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        // view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            // view.alpha = 1.0
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeDuplicateString(values: [String]) -> [String] {
        // Convert array into a set to get unique values.
        let uniques = Set<String>(values)
        // Convert set back into an Array of Ints.
        let result = Array<String>(uniques)
        return result
    }
    
    func convertArrayIntoJson(array: [String]?) -> NSString? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array ?? [], options: JSONSerialization.WritingOptions.prettyPrinted)
            
            var string = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? ""
            print(string)
            string = string.replacingOccurrences(of: "\n", with: "") as NSString
            string = string.replacingOccurrences(of: "\\\"", with: "\"") as NSString
            //        string = string.stringByReplacingOccurrencesOfString("\"", withString: "")
            string = string.replacingOccurrences(of: "\\", with: "") as NSString // removes \
            //            string = string.stringByReplacingOccurrencesOfString(" ", withString: "")
            string = string.replacingOccurrences(of: "/", with: "") as NSString
            print(string)
            print(JSON(string))
            return string
        }
        catch let error as NSError{
            print(error.description)
            return ""
        }
    }
    
    //MARK: functions
    func appendOptionalStrings(strings : [String?],separator : String) -> String{
        return strings.flatMap{$0}.joined(separator: separator)
    }
    
    func callFusumaImagePiucker(btnOutlet : UIButton? ){
        self.btnOutlet = btnOutlet
        let fusuma = FusumaViewController()
        fusuma.hasVideo = false
        fusuma.delegate = self
        self.present(fusuma, animated: true, completion: nil)
    }
    
    func viewCartCount(btnCart : MIBadgeButton!) {
        self.btnCartBadge = btnCart
        btnCartBadge.badgeEdgeInsets = UIEdgeInsetsMake(18, 0, 0, 11)
        btnCartBadge.badgeString = MMUserManager.shared.cartCount ?? ""
        btnCartBadge.badgeTextColor = UIColor.black
        btnCartBadge.badgeBackgroundColor = UIColor.orange
    }
}

//MARK::- Fusuma delegates

extension BaseViewController : FusumaDelegate{
    
    public func fusumaImageSelected(_ image: UIImage) {
        selectedImage = image
        self.txtField?.setImage(image: self.selectedImage)
        if imageButton != nil{
        self.imageButton.setImage(self.selectedImage, for: .normal)
        }
    }
    
    public func fusumaVideoCompleted(withFileURL fileURL: URL) {
    }
    
    func fusumaDismissedWithImage(_ image: UIImage) {
        print("Called just after FusumaViewController is dismissed.")
        selectedImage = image
    }
    
    func fusumaCameraRollUnauthorized() {
        UserFunctions.showAlert(message: "Camera permissions are off. Please check settings.")
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    func getTextField(textField: UITextField!){
        txtField = textField
    }
    func getButton(button: UIButton){
        imageButton = button
    }
}


//MARK::- Activity View Controller

extension BaseViewController {
    
    func shareProductApi(productId : String?) {
        ApiManager().getDataOfURL(withApi: API.ShareProduct(APIParameters.ShareProduct(productId: productId).formatParameters()), failure: { (err) in
            print(err)
        }, success: { (model) in
            UserFunctions.showAlert(title : "Success",message: "Product Shared")
        }, method: Keys.Post.rawValue, loader: true)
        
    }
    
    func showActivityViewController(text : String ,img :UIImage, viewController : UIViewController, productId : String?){
        let textToShare = text
        let image = img
        let objectsToShare = [textToShare,image] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        activityVC.completionWithItemsHandler = {
            (s, ok, items, error) in
            
            if ok {
                self.shareProductApi(productId: productId)
            }
        }
        viewController.present(activityVC, animated: true)
    }
}
