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
    var arrStores : [UserStores] = []
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewProfileStores.dataSource = collectionViewdataSource
            collectionViewProfileStores.delegate = collectionViewdataSource
        }
    }
    var userId = ""
    var pageNo : String?
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
        pageNo = "0"
        hitApiToGetUserStores()
    }
    
    func hitApiToGetUserStores() {
        ApiManager().getDataOfURL(withApi: API.GetUserStore(APIParameters.GetUserStore(type : "STORES", userId: userId,pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                
                let response = model as? AllStores ?? AllStores()
                self.pageNo = response.pageNo ?? nil
                for item in response.userStore {
                    self.arrStores.append(item)
                }
                if self.arrStores.count > 0 {
                    self.configureCollectionView()
//                    self.view.bringSubview(toFront: self.collectionViewUserItem)
                }
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
                let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
                vc.sellerId = self.arrStores[indexPath.row].id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)

            }, willDisplayCell: {[unowned self] (indexPath) in
                if indexPath.row == self.arrStores.count - 2 {
                    if let temp = self.pageNo  {
                        if temp != "" {
                            self.hitApiToGetUserStores()
                        }
                    }
                    
                }
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewProfileStores.reloadData()
    }


}
