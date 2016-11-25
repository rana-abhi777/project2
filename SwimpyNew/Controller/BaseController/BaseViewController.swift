//
//  BaseViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//
import UIKit
//import  NVActivityIndicatorView
import Fusuma

class BaseViewController: UIViewController {
    
    //MARK:- VARIABLE
    let overlayObj = LoadingOverlay()
    var selectedImage : UIImage?
    var btnOutlet : UIButton!
    let viewLoader = UIActivityIndicatorView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: functions
    
    func customButton(btn : UIButton) {
        btn.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        btn.layer.cornerRadius = 8.0
        btn.layer.shadowRadius = 5
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btn.layer.shadowColor = UIColor.lightGray.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.masksToBounds = false
        
    }
    func callFusumaImagePiucker(btnOutlet : UIButton!){
        self.btnOutlet = btnOutlet
        let fusuma = FusumaViewController()
        fusuma.hasVideo = false
        fusuma.delegate = self
        self.present(fusuma, animated: true, completion: nil)
    }
    func blackBorderRadiusToButton(btnLook : UIButton!) {
        btnLook.layer.borderWidth = 1.0
        btnLook.layer.borderColor = UIColor.black.cgColor
        btnLook.layer.cornerRadius = 4.0
    }
    func showLoader() {
        viewLoader.color = UIColor.red
        viewLoader.startAnimating()
        UserFunctions.sharedInstance().window?.rootViewController?.view.addSubview(viewLoader)
    }
    func hideLoader() {
        UserFunctions.sharedInstance().window?.rootViewController?.view.removeFromSuperview()
    }
   
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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