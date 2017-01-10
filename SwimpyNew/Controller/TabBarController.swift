//
//  TabBarController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import Alamofire


class TabBarController: UITabBarController {
    
    
    var timer = Timer()
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for:.selected)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if !Alamofire.NetworkReachabilityManager()!.isReachable {
            timer.invalidate()
            return
        }else {
            timer =   Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TabBarController.hitApiToGetCartDetails), userInfo: nil, repeats: true)
        }
        
    }
    
    func hitApiToGetCartDetails() {
        ApiManager().getDataOfURL(withApi: API.GetCartDetail(APIParameters.GetCartDetail().formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                let arrCartData = (model as? [CartData]) ?? []
                if arrCartData.count > 0 {
                    MMUserManager.shared.cartCount = "\(arrCartData.count)" ?? "0"
                }
                                print(model)
            }, method: "POST", loader: true)
    }
}
