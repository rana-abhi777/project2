//
//  BaseViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//
import UIKit
import Fusuma

class BaseViewController: UIViewController {
    
    //MARK:- VARIABLE
    let overlayObj = LoadingOverlay()
    var selectedImage : UIImage?
    var btnOutlet : UIButton!
   
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
