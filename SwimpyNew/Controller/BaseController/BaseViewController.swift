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


class BaseViewController: UIViewController {
    
    //MARK:- VARIABLE
    let overlayObj = LoadingOverlay()
    var selectedImage : UIImage?
    var btnOutlet : UIButton!
    var viewCartNumber : UIView!
    var lblCartItem : UILabel!
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    

//    let center = ModalCenterPosition.Center
//    let customType = PresentationType.Custom(width: ModalSize.Custom(size: 240), height: ModalSize.Custom(size: 128), center: center)
//    let customPresenter = Presentr(presentationType: customType)
//    customPresenter.transitionType = .CoverVertical
//    customPresenter.roundCorners = true
//    let vc = viewController as? CustomTagVC
//
//    if(selfVC == "AddTripVC"){
//    vc?.delegate = delegateVC as? AddTripVC
//    }
//    else if selfVC == "EditTripVC" {
//    vc?.delegate = delegateVC as? EditTripVC
//    }
//    else{
//    vc?.delegate = delegateVC as? EditProfileVC
//    }
//    
//    self.customPresentViewController(customPresenter, viewController:vc! , animated: true, completion: nil)
    
    //MARK: functions
    
    func appendOptionalStrings(strings : [String?],separator : String) -> String{
        return strings.flatMap{$0}.joined(separator: separator)
    }
    
    func callFusumaImagePiucker(btnOutlet : UIButton!){
        self.btnOutlet = btnOutlet
        let fusuma = FusumaViewController()
        fusuma.hasVideo = false
        fusuma.delegate = self
        self.present(fusuma, animated: true, completion: nil)
    }
    
    func viewCartCount(viewCartNotification : UIView!, lblCartCount : UILabel!) {
        self.viewCartNumber = viewCartNotification
        self.lblCartItem = lblCartCount
        guard let count = Int(MMUserManager.shared.cartCount ?? L10n._0.string)else {
            viewCartNumber.isHidden = true
            view.sendSubview(toBack: viewCartNumber)
            return
        }
        if count > 0 {
            viewCartNumber.isHidden = false
            view.bringSubview(toFront: viewCartNumber)
            lblCartItem.text = MMUserManager.shared.cartCount ?? L10n._0.string
        }
        else {
            viewCartNumber.isHidden = true
            view.sendSubview(toBack: viewCartNumber)
        }
    }
    

}

//MARK::- Fusuma delegates

extension BaseViewController : FusumaDelegate{
    
    public func fusumaImageSelected(_ image: UIImage) {
        selectedImage = image
        btnOutlet.setImage(selectedImage ?? UIImage(), for: .normal)
    }
    
    public func fusumaVideoCompleted(withFileURL fileURL: URL) {
    }
    
    func fusumaDismissedWithImage(_ image: UIImage) {
        print("Called just after FusumaViewController is dismissed.")
    }
    
    func fusumaCameraRollUnauthorized() {
        print("Camera roll unauthorized")
    }
    
}
