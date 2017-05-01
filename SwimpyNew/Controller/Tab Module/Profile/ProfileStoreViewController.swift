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
    
    @IBOutlet weak var viewNoStores: UIView!
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
    let refreshControl = UIRefreshControl()
    var isLoadMore = false
    var flagWillAppear = true
    
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        handlePagination()
        flagWillAppear = false
        refreshControl.addTarget(self, action: #selector(ProfileStoreViewController.setup), for: UIControlEvents.valueChanged)
        collectionViewProfileStores?.refreshControl =  refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
            setup()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK:- IndicatorInfoProvider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Store")
    }
    
    //MARK:- functions
    
    func resetNoMoreData(){
        self.collectionViewProfileStores.es_resetNoMoreData()
    }
    
    func foundNoMoreData(){
        self.collectionViewProfileStores.es_stopLoadingMore()
        self.collectionViewProfileStores.es_noticeNoMoreData()
    }
    
    func handlePagination(){
        let _ = collectionViewProfileStores.es_addInfiniteScrolling { [unowned self] in
            if self.pageNo != "" {
                self.hitApiToGetUserStores()
            }else{
                self.foundNoMoreData()
            }
        }
    }
    
    func setup() {
        resetNoMoreData()
        arrStores = []
        pageNo = L10n._0.string
        hitApiToGetUserStores()
        configureCollectionView()
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
                self.isLoadMore = response.userStore.count > 0
                self.collectionViewProfileStores.es_stopLoadingMore()
                self.isLoadMore ? self.collectionViewProfileStores.es_resetNoMoreData() : self.collectionViewProfileStores.es_noticeNoMoreData()
                
                self.refreshControl.endRefreshing()
                if self.arrStores.count > 0 {
                    self.configureCollectionView()
                    self.view.bringSubview(toFront: self.collectionViewProfileStores)
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoStores)
                }
            }, method: Keys.Post.rawValue, loader: false)
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrStores, collectionView: collectionViewProfileStores, cellIdentifier: CellIdentifiers.ProfileStoreCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 168, cellWidth: (collectionViewProfileStores.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            
            let cell = cell as? ProfileStoreCollectionViewCell
            cell?.configureCell(model: self.arrStores[indexpath.row])
            
            }, aRowSelectedListener: {[unowned self] (indexPath) in
                let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
                vc.sellerId = /self.arrStores[indexPath.row].id
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, willDisplayCell: {[unowned self] (indexPath) in
                if let temp = self.pageNo , temp != "" ,  indexPath.row == self.arrStores.count - 2 {
                    self.hitApiToGetUserStores()
                }
                
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewProfileStores.reloadData()
    }
    
    
}
