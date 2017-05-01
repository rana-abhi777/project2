//
//  LoadingOverlay.swift
//  PowWow
//
//  Created by Aseem 10 on 9/24/16.
//  Copyright © 2016 Kunal Gupta. All rights reserved.
//

import UIKit

class LoadingOverlay: UIView {

    var overlayView = UIView()

    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }

     func showOverlay(view: UIView) {
        overlayView.frame = CGRect(x:0,y: 0,width: UIScreen.main.bounds.width,  height : UIScreen.main.bounds.height)
        overlayView.backgroundColor = UIColor.overlay()
        overlayView.clipsToBounds = true
        view.addSubview(overlayView)

    }

     func hideOverlayView() {
        overlayView.removeFromSuperview()
    }
}
