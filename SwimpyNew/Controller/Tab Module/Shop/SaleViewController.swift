//
//  SaleViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SaleViewController: UIViewController ,IndicatorInfoProvider,SalesTask {
    
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
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //MARK:- FUNCTION
    func initialize() {
        arrProduct = []
        pageNo = "0"
        hitApiForSaleProduct()
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewSale, cellIdentifier: CellIdentifiers.SaleCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewSale.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? SaleCollectionViewCell
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
                            self.hitApiForSaleProduct()
                        }
                    }
                   
                }
                
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
                print(response.arrProducts.count)
                for item in response.arrProducts {
                    self.arrProduct.append(item)
                }
                if self.arrProduct.count > 0 {
                    self.configureCollectionView()
                    self.view.bringSubview(toFront: self.collectionViewSale)
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoProduct)
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
        return IndicatorInfo(title: "Sale")
    }
    
    
}
