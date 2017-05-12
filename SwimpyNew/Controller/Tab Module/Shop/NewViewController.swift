//
//  NewViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class NewViewController: UIViewController , IndicatorInfoProvider {
    
    //MARK:- variables
    var categoryId : String?
    var arrStores:[Stores] = []
    var data: StoreDetail?
    var allData:AllSellerForUser?
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewNewProducts.dataSource = collectionViewdataSource
            collectionViewNewProducts.delegate = collectionViewdataSource
        }
    }
    var pageNo : String?
    let refreshControl = UIRefreshControl()
    var isLoadMore = false
    var storeName : String?
    //MARK:- outlets
    @IBOutlet weak var collectionViewNewProducts: UICollectionView!
    @IBOutlet weak var viewNoProducts: UIView!
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        handlePagination()
        refreshControl.addTarget(self, action: #selector(NewViewController.setup), for: UIControlEvents.valueChanged)
        collectionViewNewProducts?.refreshControl =  refreshControl
        setup()
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        setup()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- FUNCTION
    func resetNoMoreData(){
        self.collectionViewNewProducts.es_resetNoMoreData()
    }
    
    func foundNoMoreData(){
        self.collectionViewNewProducts.es_stopLoadingMore()
        self.collectionViewNewProducts.es_noticeNoMoreData()
    }
    
    func handlePagination(){
        let _ = collectionViewNewProducts.es_addInfiniteScrolling { [unowned self] in
            if self.pageNo !=  StringNames.empty.rawValue {
                self.hitApiForAllSellers()
            }else{
                self.foundNoMoreData()
            }
        }
    }
    
    func hitAPIForStoreDetails(sellerId: String?){
        ApiManager().getDataOfURL(withApi: API.GetStoreDetail(APIParameters.GetStoreDetail(sellerId: sellerId, pageNo: pageNo).formatParameters()), failure: { (err) in
            print(err)
        }, success: { [unowned self] (model) in
            self.data = model as? StoreDetail ?? StoreDetail()
            }, method: Keys.Get.rawValue, loader: false)
    }
    
    func setup() {
        resetNoMoreData()
        arrStores = []
        pageNo = L10n._0.string
        hitApiForAllSellers()
        hitApiForGetAllSellerForUser()
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: self.allData?.userStore, collectionView: collectionViewNewProducts, cellIdentifier: CellIdentifiers.StoresCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewNewProducts.frame.size.width - 5)/2, cellSpacing: 5, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell1 = cell as? StoresCollectionViewCell
            cell1?.btnShopToStore.tag = indexpath.item
            cell1?.btnMessageToStore.tag = indexpath.item
            cell1?.btnFollowStore.tag = indexpath.item
            if /self.allData?.userStore.count > 0{
                cell1?.configureCell(model: (self.allData?.userStore[indexpath.item])!,row : indexpath.row)
                var status = Int(/self.allData?.userStore[indexpath.row].followStatus)
                cell1?.btnFollowStore.setTitle(status == 0 ? Keys.follow.rawValue : Keys.followed.rawValue, for:.normal)
                cell1?.btnFollowStore.setTitleColor(status != 0 ? UIColor.followedColor(): UIColor.unFollowColor(), for: .normal)
            }
            }, aRowSelectedListener: {(indexPath) in
                let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
                vc.sellerId = /self.arrStores[indexPath.row].id
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
        }, willDisplayCell: { (indexPath) in
            
        }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewNewProducts.reloadData()
    }
    
    
    func hitApiForGetAllSellerForUser(){
        ApiManager().getDataOfURL(withApi: API.GetAllSellerForUser(APIParameters.GetAllSellerForUser(pageNo: pageNo).formatParameters()), failure: { (err) in
            print(err)
        }, success: { (model) in
            self.allData = model as? AllSellerForUser ?? AllSellerForUser()
        }, method: Keys.Get.rawValue, loader: false)
    }
    func hitApiForAllSellers(){
        ApiManager().getDataOfURL(withApi: API.GetAllSeller(APIParameters.GetAllSeller(pageNo: pageNo).formatParameters()), failure: { (err) in
            print(err)
        }, success: {[unowned self] (model) in
            let response = model as? AllStoreResponse ?? AllStoreResponse()
            self.pageNo = response.pageNo ?? nil
            for item in response.arrStores{
                self.arrStores.append(item)
            }
            self.isLoadMore = response.arrStores.count > 0
            self.collectionViewNewProducts.es_stopLoadingMore()
            self.isLoadMore ?  self.collectionViewNewProducts.es_resetNoMoreData() : self.collectionViewNewProducts.es_noticeNoMoreData()
            self.refreshControl.endRefreshing()
            if self.arrStores.count > 0 {
                self.configureCollectionView()
                self.view.bringSubview(toFront: self.collectionViewNewProducts)
            }
            else {
                self.view.bringSubview(toFront: self.viewNoProducts)
            }}, method: Keys.Get.rawValue , loader : self.arrStores.count == 0)
    }
    
    
    //MARK:- indicator info provider delegate
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        //Title under Shop Tab
        return IndicatorInfo(title: Keys.stores.rawValue)
    }
    
    @IBAction func btnSendToStore(_ sender: CustomButton) {
        let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
        vc.sellerId = /self.arrStores[sender.tag].id
        vc.delegate = self
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
    @IBAction func btnMessageToStore(_ sender: UIButton) {
        let vc = StoryboardScene.Main.instantiateMessageViewController()
        vc.storeId = /self.arrStores[sender.tag].id
        vc.storeImage = /self.arrStores[sender.tag].profilePicThumbnail
        self.navigationController?.pushViewController(vc,animated: true)
    }
    
    @IBAction func btnFollowTheStore(_ sender: CustomButton) {
        if UserFunctions.checkInternet(){
            ApiManager().getDataOfURL(withApi: API.FollowStore(APIParameters.FollowStore(sellerId: /self.allData?.userStore[sender.tag].id).formatParameters(), type: /self.allData?.userStore[sender.tag].followStatus == StringNames.one.rawValue), failure: { (err) in
                print(err)
            }, success: { (model) in
                sender.setTitle(sender.titleLabel?.text == Keys.follow.rawValue ? Keys.followed.rawValue : Keys.follow.rawValue, for: .normal)
                sender.setTitleColor(sender.titleLabel?.text != Keys.followed.rawValue ? UIColor.followedColor() : UIColor.unFollowColor(), for: .normal)
            }, method: Keys.Put.rawValue, loader: false)
        }
        else{
            UserFunctions.showAlert(message: L10n.yourInternetConnectionSeemsToBeOffline.string)
        }
    }
}

extension NewViewController: StoreProfileDelegate{
    func getUpdateFollowData(model: StoreDetail) {
        self.data = model
        configureCollectionView()
    }
}
