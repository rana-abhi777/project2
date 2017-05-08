//
//  PopularViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PopularViewController: UIViewController,IndicatorInfoProvider {
    
    //MARK:- OUTLET
    @IBOutlet weak var viewNoProduct: UIView!
    @IBOutlet weak var collectionViewPopularProducts: UICollectionView!
    
    //MARK:- variable
    
    var arrProduct : [Products] = []
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewPopularProducts.dataSource = collectionViewdataSource
            collectionViewPopularProducts.delegate = collectionViewdataSource
        }
    }
    var pageNo : String?
    let refreshControl = UIRefreshControl()
    var isLoadMore = false
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        handlePagination()
        refreshControl.addTarget(self, action: #selector(PopularViewController.setup), for: UIControlEvents.valueChanged)
        collectionViewPopularProducts?.refreshControl =  refreshControl
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- FUNCTION
    
    
    func resetNoMoreData(){
        self.collectionViewPopularProducts.es_resetNoMoreData()
    }
    
    func foundNoMoreData(){
        self.collectionViewPopularProducts.es_stopLoadingMore()
        self.collectionViewPopularProducts.es_noticeNoMoreData()
    }
    
    
    func handlePagination(){
        let _ = collectionViewPopularProducts.es_addInfiniteScrolling { [unowned self] in
            if self.pageNo != "" {
                self.hitApiForPopularProduct()
            }else{
                self.foundNoMoreData()
            }
            
        }
    }
   
    func setup() {
        resetNoMoreData()
        arrProduct = []
        pageNo = L10n._0.string
        hitApiForPopularProduct()
     //   configureCollectionView()
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewPopularProducts, cellIdentifier: CellIdentifiers.DealsCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewPopularProducts.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? DealsCollectionViewCell
            cell?.delegate = self
            if self.arrProduct.count > 0 {
            cell?.configureCell(model: self.arrProduct[indexpath.row],row : indexpath.row)
            }
            
            }, aRowSelectedListener: { (indexPath) in
                
                let productId = /self.arrProduct[indexPath.row].id
                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
                vc.productId = productId
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, willDisplayCell: {(indexPath) in
               
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewPopularProducts.reloadData()
    }
    
    
    func hitApiForPopularProduct() {
        ApiManager().getDataOfURL(withApi: API.GetPopularProduct(APIParameters.GetPopularProduct(pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                let response = model as? ProductResponse ?? ProductResponse()
                self.pageNo = response.pageNo ?? nil
                for item in response.arrProducts {
                    self.arrProduct.append(item)
                }
                self.isLoadMore = response.arrProducts.count > 0
                self.collectionViewPopularProducts.es_stopLoadingMore()
                self.isLoadMore ? self.collectionViewPopularProducts.es_resetNoMoreData() : self.collectionViewPopularProducts.es_noticeNoMoreData()
                self.refreshControl.endRefreshing()
                
                if self.arrProduct.count > 0 {
                    self.configureCollectionView()
                    self.view.bringSubview(toFront: self.collectionViewPopularProducts)
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoProduct)
                }
                print(model)
            }, method: Keys.Get.rawValue, loader: self.arrProduct.count == 0)
    }
    
    //MARK:- indicator info provide delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: Keys.popular.rawValue)
    }
    
}
//MARK:- DELEGATE function
extension PopularViewController : DealsProductTask{
    func updateLikeData(model : Products?,index : Int) {
        guard let temp = model else { return }
        arrProduct[index] = temp
        configureCollectionView()
    }
    func shareProduct(model : Products?, index : Int) {
    }
}
