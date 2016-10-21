//
//  InboxViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController {

    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.selectedImage = UIImage(asset: .Ic_inbox_on)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- button actions
    @IBAction func btnActionCart(sender: AnyObject) {
    }
    @IBAction func btnSearchAction(sender: AnyObject) {
        let VC = StoryboardScene.Main.SearchViewControllerScene.viewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
   
}
