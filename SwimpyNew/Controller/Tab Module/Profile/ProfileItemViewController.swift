//
//  ProfileItemViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileItemViewController: BaseViewController,IndicatorInfoProvider {
    
    //MARK:- outlets
    @IBOutlet weak var collectionViewUserItem: UICollectionView!
    @IBOutlet weak var viewNoItem: UIView!
    
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
    let refreshControl = UIRefreshControl()
    var isLoadMore = false
    var counter = 0
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //handlePagination()
        refreshControl.addTarget(self, action: #selector(ProfileItemViewController.setup), for: UIControlEvents.valueChanged)
        collectionViewUserItem?.refreshControl =  refreshControl
        //setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(counter != 0) {
           setup()
        }
        counter += 1
        
    }
    
    //MARK:- functions
    
    func resetNoMoreData(){
        self.collectionViewUserItem.es_resetNoMoreData()
    }
    
    func foundNoMoreData(){
        self.collectionViewUserItem.es_stopLoadingMore()
        self.collectionViewUserItem.es_noticeNoMoreData()
    }
    
    func handlePagination(){
        let _ = collectionViewUserItem.es_addInfiniteScrolling { [unowned self] in
            if self.pageNo != "" {
                self.hitApiToGetUserItems()
            }else{
                self.foundNoMoreData()
            }
        }
    }
    
    func setup() {
        resetNoMoreData()
        arrProduct = []
        pageNo = L10n._0.string
        hitApiToGetUserItems()
        //configureCollectionView()
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
                
                self.isLoadMore = response.arrProducts.count > 0
                self.collectionViewUserItem.es_stopLoadingMore()
                self.isLoadMore ? self.collectionViewUserItem.es_resetNoMoreData() : self.collectionViewUserItem.es_noticeNoMoreData()
                
                
                self.refreshControl.endRefreshing()
                if self.arrProduct.count > 0 {
                    self.configureCollectionView()
                    self.view.bringSubview(toFront: self.collectionViewUserItem)
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoItem)
                    
                }
                
               
            }, method: Keys.Post.rawValue, loader: true)
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewUserItem, cellIdentifier: CellIdentifiers.DealsCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewUserItem.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? DealsCollectionViewCell
            cell?.delegate = self
            if self.arrProduct.count > 0{
            cell?.configureCell(model: self.arrProduct[indexpath.row], row: indexpath.row)
            }
            }, aRowSelectedListener: {[unowned self] (indexPath) in
                let productId = self.arrProduct[indexPath.row].id ?? ""
                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
                vc.productId = productId
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, willDisplayCell: {[unowned self] (indexPath) in
//                    if let temp = self.pageNo , indexPath.row == self.arrProduct.count - 2  {
//                        if temp != "" {
//                            self.hitApiToGetUserItems()
//                        }
//                    }
                
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewUserItem.reloadData()
    }
    
    //MARK:- IndicatorInfoProvider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Item")
    }
    
    
}

//MARK:- DELEGATE FUNCTION
extension ProfileItemViewController : DealsProductTask {
    
    func updateLikeData(model : Products?, index : Int) {
        arrProduct[index] = model ?? Products()
        configureCollectionView()
    }
    
}
