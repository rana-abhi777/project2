//
//  PopularViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PopularViewController: UIViewController,IndicatorInfoProvider,PopularProductTask {
    
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
        hitApiForPopularProduct()
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewPopularProducts, cellIdentifier: CellIdentifiers.PopularProductCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewPopularProducts.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? PopularProductCollectionViewCell
            cell?.layer.cornerRadius = 4.0
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
             cell?.delegate = self
            cell?.configureCell(model: self.arrProduct[indexpath.row],row : indexpath.row)
           
            }, aRowSelectedListener: { (indexPath) in
                
                let productId = self.arrProduct[indexPath.row].id ?? ""
                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
                vc.productId = productId
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewPopularProducts.reloadData()
    }
    
    
    func hitApiForPopularProduct() {
        ApiManager().getDataOfURL(withApi: API.GetPopularProduct(APIParameters.GetPopularProduct().formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.arrProduct =  (model as? [Products]) ?? []
                if self.arrProduct.count > 0 {
                    self.configureCollectionView()
                    self.view.bringSubview(toFront: self.collectionViewPopularProducts)
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
    
    //MARK:- indicator info provide delegate
    
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Popular")
    }
    
}
