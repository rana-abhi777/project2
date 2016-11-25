//
//  DealsViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DealsViewController: BaseViewController,IndicatorInfoProvider {

    //MARK:- variables
    var categoryId : String?
    var arrProduct : [Products] = []
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewDeals.dataSource = collectionViewdataSource
            collectionViewDeals.delegate = collectionViewdataSource
        }
    }
    
    //MARK:- outlets
    @IBOutlet weak var collectionViewDeals: UICollectionView!
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- functions
    func initialize() {
        hitApiForCategory()
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewDeals, cellIdentifier: CellIdentifiers.DealsCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewDeals.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? DealsCollectionViewCell
            cell?.layer.cornerRadius = 4.0
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
            cell?.configureCell(model: self.arrProduct[indexpath.row])
            }, aRowSelectedListener: { (indexPath) in
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewDeals.reloadData()
    }
    
    
    func hitApiForCategory() {
        ApiManager().getDataOfURL(withApi: API.GetCategoryResults(APIParameters.GetCategoryResults(categoryId: categoryId).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.arrProduct =  (model as? [Products]) ?? []
                self.configureCollectionView()
                print(model)
            }, method: "GET", loader: true)
    }
    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Deals")
    }

    
  

}
