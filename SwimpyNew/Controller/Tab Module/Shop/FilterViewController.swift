//
//  FilterViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/7/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- button actions
    @IBAction func btnActionFollowStore(sender: AnyObject) {
    }
    @IBAction func btnActionMessage(sender: AnyObject) {
    }
    @IBAction func btnActionSort(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateSortViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnActionFilter(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateFilterViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnActionCart(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateCartViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnActionSearch(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateSearchViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnActionBack(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }


}
