//
//  Fusuma.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 2/2/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import Fusuma

class Fusuma: NSObject , FusumaDelegate {

    var btnOutlet : UIButton!
    var obj : FusumaViewController!
    
    init(btn : UIButton) {
        super.init()
        btnOutlet = btn
        obj = FusumaViewController()
        obj.hasVideo = false
        obj.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func fusumaImageSelected(_ image: UIImage) {
        btnOutlet.setImage(image ?? UIImage(), for: .normal)
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
