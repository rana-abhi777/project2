//
//  ProfileStoreViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileStoreViewController: BaseViewController,IndicatorInfoProvider  {

    //MARK:- OUTLETS
    @IBOutlet weak var collectionViewProfileStores: UICollectionView!
    
    //MARK:- variables
    var arrStores : [StoreDetail] = []
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewProfileStores.dataSource = collectionViewdataSource
            collectionViewProfileStores.delegate = collectionViewdataSource
        }
    }
    var userId = ""
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- IndicatorInfoProvider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Store")
    }
    
    //MARK:- functions
    func initialize() {
        hitApiToGetUserStores()
    }
    
    func hitApiToGetUserStores() {
        ApiManager().getDataOfURL(withApi: API.GetUserStore(APIParameters.GetUserStore(type : "STORES").formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.arrStores = (model as? [StoreDetail]) ?? []
                self.configureCollectionView()
                print(self.arrStores.count)
            }, method: "POST", loader: true)
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrStores, collectionView: collectionViewProfileStores, cellIdentifier: CellIdentifiers.ProfileStoreCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 168, cellWidth: (collectionViewProfileStores.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? ProfileStoreCollectionViewCell
            cell?.layer.cornerRadius = 4.0
//            cell?.delegate = self
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
            cell?.configureCell(model: self.arrStores[indexpath.row])
            }, aRowSelectedListener: {[unowned self] (indexPath) in
            }, willDisplayCell: {[unowned self] (indexPath) in
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewProfileStores.reloadData()
    }


}
