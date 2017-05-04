//
//  SearchViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SearchViewController: BasePageViewController {
    
    //MARK:- outlet
    @IBOutlet weak var txtFieldSearch: UITextField!
    
    //MARK:- variable
    let searchItemVC = StoryboardScene.Main.instantiateSearchItemViewController()
    let searchStoreVC = StoryboardScene.Main.instantiateSearchStoreViewController()
    let searchPeopleVC = StoryboardScene.Main.instantiateSearchPeopleViewController()
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(SearchViewController.textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: txtFieldSearch)
        pageVCSetup()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func getViewControllers() -> [UIViewController] {
        return [searchItemVC,searchStoreVC,searchPeopleVC]
    }
        
    //MARK:- button action
    @IBAction func btnActionCancel(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController  {
    
    func textFieldDidChange(notification: NSNotification) {
        guard let text = txtFieldSearch.text else { return }
        print(text)
        searchItemVC.text = text
        searchStoreVC.text = text
        searchPeopleVC.text = text
        
    }
    
}
