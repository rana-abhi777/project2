//
//  DealsViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DealsViewController: BaseViewController,IndicatorInfoProvider,DealsProductTask {
    
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
    
    
    //MARK:- outlets
    @IBOutlet weak var collectionViewDeals: UICollectionView!
    @IBOutlet weak var viewNoProducts: UIView!
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(DealsViewController.initialize), for: UIControlEvents.valueChanged)
        collectionViewDeals?.refreshControl =  refreshControl
        initialize()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- FUNCTION
    func initialize() {
        pageNo = L10n._0.string
        //        arrProduct = []
        //        configureCollectionView()
        hitApiForPopularProduct()
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewDeals, cellIdentifier: CellIdentifiers.DealsCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewDeals.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? DealsCollectionViewCell
            cell?.layer.cornerRadius = 4.0
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
            cell?.delegate = self
            cell?.configureCell(model: self.arrProduct[indexpath.row],row : indexpath.row)
            
            }, aRowSelectedListener: {[unowned self] (indexPath) in
                let productId = self.arrProduct[indexPath.row].id ?? ""
                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
                vc.productId = productId
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, willDisplayCell: {[unowned self] (indexPath) in
                if indexPath.row == self.arrProduct.count - 2 {
                    if let temp = self.pageNo  {
                        if temp != "" {
                            self.hitApiForPopularProduct()
                        }
                    }
                }
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewDeals.reloadData()
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
                self.refreshControl.endRefreshing()
                if self.arrProduct.count > 0 {
                    self.configureCollectionView()
                    self.view.bringSubview(toFront: self.collectionViewDeals)
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoProducts)
                    
                }
                print(model)
            }, method: "GET", loader: true)
    }
    
    func updateLikeData(model : Products?,index : Int) {
        arrProduct[index] = model ?? Products()
        configureCollectionView()
    }
    
    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Deals")
    }
    
    
}
