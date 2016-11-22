//
//  CategoriesViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CategoriesViewController: UIViewController , IndicatorInfoProvider {
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func initialize() {
       ApiManager().getDataOfURL(withApi: API.GetCategory(APIParameters.GetCategory().formatParameters()), failure: { (err) in
        print(err)
        }, success: { (model) in
            print(model)
        }, method: "POST", loader: true)

    }
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Categories")
    }

}
