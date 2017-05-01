//
//  SaleViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SaleViewController: UIViewController ,IndicatorInfoProvider {
    
    //MARK:- OUTLET
    
    @IBOutlet weak var viewNoProduct: UIView!
    @IBOutlet weak var collectionViewSale: UICollectionView!
    
    //MARK:- variable
    
    var arrProduct : [Products] = []
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewSale.dataSource = collectionViewdataSource
            collectionViewSale.delegate = collectionViewdataSource
        }
    }
    var pageNo : String?
    let refreshControl = UIRefreshControl()
    var isLoadMore = false
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(SaleViewController.setup), for: UIControlEvents.valueChanged)
        collectionViewSale?.refreshControl =  refreshControl
        handlePagination()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //MARK:- FUNCTION
    
    func resetNoMoreData(){
        self.collectionViewSale.es_resetNoMoreData()
    }
    
    func foundNoMoreData(){
        self.collectionViewSale.es_stopLoadingMore()
        self.collectionViewSale.es_noticeNoMoreData()
    }
    
    func handlePagination(){
        let _ = collectionViewSale.es_addInfiniteScrolling { [unowned self] in
            if self.pageNo != "" {
                self.hitApiForSaleProduct()
            }else{
                self.foundNoMoreData()
            }
        }
    }
    
    
    
    func setup() {
        resetNoMoreData()
        arrProduct = []
        //configureCollectionView()
        pageNo = L10n._0.string
        hitApiForSaleProduct()
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewSale, cellIdentifier: CellIdentifiers.DealsCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewSale.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? DealsCollectionViewCell
            cell?.delegate = self
            if self.arrProduct.count > 0{
            cell?.configureCell(model: self.arrProduct[indexpath.row], row: indexpath.row)
            }
            
            }, aRowSelectedListener: {[unowned self] (indexPath) in
                
                let productId = /self.arrProduct[indexPath.row].id
                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
                vc.productId = productId
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, willDisplayCell: {(indexPath) in
                
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewSale.reloadData()
    }
    
    
    func hitApiForSaleProduct() {
        ApiManager().getDataOfURL(withApi: API.GetSaleProduct(APIParameters.GetSaleProduct(pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                let response = model as? ProductResponse ?? ProductResponse()
                self.pageNo = response.pageNo ?? nil
                
                for item in response.arrProducts {
                    self.arrProduct.append(item)
                }
                self.isLoadMore = response.arrProducts.count > 0
                self.collectionViewSale.es_stopLoadingMore()
                self.isLoadMore ? self.collectionViewSale.es_resetNoMoreData() : self.collectionViewSale.es_noticeNoMoreData()
                
                self.refreshControl.endRefreshing()
                if self.arrProduct.count > 0 {
                    self.configureCollectionView()
                    self.view.bringSubview(toFront: self.collectionViewSale)
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoProduct)
                }
            }, method: Keys.Get.rawValue, loader: self.arrProduct.count == 0)
    }
    
    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: Keys.sales.rawValue)
    }
    
    
}
//MARK:- DELEGATE function
extension SaleViewController : DealsProductTask{
    
    func updateLikeData(model : Products?,index : Int) {
        guard let temp = model else { return }
        arrProduct[index] = temp
        configureCollectionView()
    }
    func shareProduct(model : Products?, index : Int) {
          }
}
