//
//  DealsViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import ESPullToRefresh

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
    var pageNo : String?
    let refreshControl = UIRefreshControl()
    var isLoadMore = false
    
    //MARK:- outlets
    @IBOutlet weak var collectionViewDeals: UICollectionView!
    @IBOutlet weak var viewNoProducts: UIView!
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        handlePagination()
        refreshControl.addTarget(self, action: #selector(DealsViewController.setup), for: UIControlEvents.valueChanged)
        collectionViewDeals?.refreshControl =  refreshControl
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setup()
    }
    
    //MARK:- FUNCTION
    
    func resetNoMoreData(){
        self.collectionViewDeals.es_resetNoMoreData()
    }
    
    func foundNoMoreData(){
        self.collectionViewDeals.es_stopLoadingMore()
        self.collectionViewDeals.es_noticeNoMoreData()
    }
    
    func setup() {
        resetNoMoreData()
        arrProduct = []
        pageNo = L10n._0.string
        //        configureCollectionView()
        hitApiForPopularProduct()
    }
    
    func handlePagination(){
        let _ = collectionViewDeals.es_addInfiniteScrolling { [unowned self] in
            if self.pageNo != StringNames.empty.rawValue {
                self.hitApiForPopularProduct()
            }else{
                self.foundNoMoreData()
            }
            
        }
    }
    
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewDeals, cellIdentifier: CellIdentifiers.DealsCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewDeals.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? DealsCollectionViewCell
            cell?.delegate = self
            if self.arrProduct.count > 0{
                cell?.configureCell(model: self.arrProduct[indexpath.row],row : indexpath.row)
            }
            }, aRowSelectedListener: {[unowned self] (indexPath) in
                let productId = self.arrProduct[indexPath.row].id
                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
                vc.productId = productId ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }, willDisplayCell: {(indexPath) in
        }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewDeals.reloadData()
    }
    
    func hitApiForPopularProduct() {
        ApiManager().getDataOfURL(withApi: API.GetPopularProduct(APIParameters.GetPopularProduct(pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
        }, success: {[unowned self] (model) in
            let response = model as? ProductResponse ?? ProductResponse()
            self.pageNo = response.pageNo
            for item in response.arrProducts {
                self.arrProduct.append(item)
            }
            
            //sorting array according to flatDiscount on the Products
            self.arrProduct.sort(by: {/$1.flatDiscount < /$0.flatDiscount})
            self.isLoadMore = response.arrProducts.count > 0
            self.collectionViewDeals.es_stopLoadingMore()
            self.isLoadMore ? self.collectionViewDeals.es_resetNoMoreData() : self.collectionViewDeals.es_noticeNoMoreData()
            self.refreshControl.endRefreshing()
            if self.arrProduct.count > 0 {
                self.configureCollectionView()
                self.view.bringSubview(toFront: self.collectionViewDeals)
            }
            else {
                self.view.bringSubview(toFront: self.viewNoProducts)
            }
            }, method: Keys.Get.rawValue, loader: self.arrProduct.count == 0)
    }
    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: Keys.deals.rawValue)
    }
}
//MARK:- DELEGATE FUNCTION
extension DealsViewController : DealsProductTask {
    func updateLikeData(model : Products?, index : Int) {
        guard let temp = model else { return }
        arrProduct[index] = temp
        configureCollectionView()
    }
    func shareProduct(model : Products?, index : Int) {
        
    }
}
