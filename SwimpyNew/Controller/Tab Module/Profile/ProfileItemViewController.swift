//
//  ProfileItemViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileItemViewController: BaseViewController,IndicatorInfoProvider,ProfileItemTask {
   
    @IBOutlet weak var collectionViewUserItem: UICollectionView!
    
    //MARK:- variable
    var arrProduct : [Products] = []
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewUserItem.dataSource = collectionViewdataSource
            collectionViewUserItem.delegate = collectionViewdataSource
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
    
    //MARK:- functions
    
    func initialize() {
        arrProduct = []
        configureCollectionView()
        pageNo = "0"
        hitApiToGetUserItems()
    }
    
    func hitApiToGetUserItems() {
        ApiManager().getDataOfURL(withApi: API.GetUserItem(APIParameters.GetUserItem(type : "ITEMS", userId: userId,pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                
                let response = model as? ProductResponse ?? ProductResponse()
                self.pageNo = response.pageNo ?? nil
                for item in response.arrProducts {
                    self.arrProduct.append(item)
                }
                if self.arrProduct.count > 0 {
                    self.configureCollectionView()
                    self.view.bringSubview(toFront: self.collectionViewUserItem)
                }
                
                
//                self.arrProduct = model as? [Products] ?? []
//                print(self.arrProduct.count)
////                self.arrProduct = response.arrProducts
//                self.configureCollectionView()
            }, method: "POST", loader: true)
        
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewUserItem, cellIdentifier: CellIdentifiers.ProfileItemCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewUserItem.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? ProfileItemCollectionViewCell
            cell?.layer.cornerRadius = 4.0
            cell?.delegate = self
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
            cell?.configureCell(model: self.arrProduct[indexpath.row], row: indexpath.row)
            }, aRowSelectedListener: {[unowned self] (indexPath) in
                
                let productId = self.arrProduct[indexPath.row].id ?? ""
                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
                vc.productId = productId
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, willDisplayCell: {[unowned self] (indexPath) in
                if indexPath.row == self.arrProduct.count - 2 {
                    if let temp = self.pageNo  {
                        if temp != "" {
                            self.hitApiToGetUserItems()
                        }
                    }
                    
                }
                
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewUserItem.reloadData()
    }
    func updateLikeData(model : Products?, index : Int) {
        arrProduct[index] = model ?? Products()
        configureCollectionView()
    }
    
    //MARK:- IndicatorInfoProvider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Item")
    }


}
