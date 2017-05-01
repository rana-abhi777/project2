//
//  SearchItemViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire

class SearchItemViewController: UIViewController , IndicatorInfoProvider ,SearchProductTask{
    
    
    //MARK:- outlets
    @IBOutlet weak var collectionViewSearchItem: UICollectionView!
    @IBOutlet weak var viewNoProduct: UIView!
    
    //MARK:- variable
    var text = ""
    var timer = Timer()
    var arrProduct : [Item] = []
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewSearchItem.dataSource = collectionViewdataSource
            collectionViewSearchItem.delegate = collectionViewdataSource
        }
    }
    var collectionViewLoaderDataSource : SearchLoaderDatasource?{
        didSet{
            collectionViewSearchItem.dataSource = collectionViewLoaderDataSource
            collectionViewSearchItem.delegate = collectionViewLoaderDataSource
        }
    }
    var oldText : String?
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if !Alamofire.NetworkReachabilityManager()!.isReachable {
            timer.invalidate()
            return
        }else {
            configureLoader()
            timer =   Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SearchItemViewController.hitApiToGetSearchResult), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- function
    
    func hitApiToGetSearchResult() {
        if text == "" {
            configureLoader()
//             self.view.bringSubview(toFront: self.viewNoProduct)
            return
        }
        if text == oldText {
            return
        }
        configureLoader()
        
        ApiManager().getDataOfURL(withApi: API.GetSearchAll(APIParameters.GetSearchAll(text: text, value: "item").formatParameters()), failure: { (err) in
            print(err)
            
            }, success: { (model) in
                
                guard let data = model as? SearchResult else { return }
                self.oldText = data.text
                self.arrProduct = data.dataitem ?? []
                if self.arrProduct.count > 0 {
                    self.view.bringSubview(toFront: self.collectionViewSearchItem)
                    self.configureCollectionView()
                    
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoProduct)
                }
                print(model)
                
            }, method: Keys.Get.rawValue, loader: false)
    }
    
    func configureLoader() {
        collectionViewLoaderDataSource = SearchLoaderDatasource(colectionView: collectionViewSearchItem)
        collectionViewSearchItem.reloadData()
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewSearchItem, cellIdentifier: CellIdentifiers.SearchItemCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewSearchItem.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? SearchItemCollectionViewCell
            cell?.layer.cornerRadius = 4.0
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor.border()
            cell?.delegate = self
            cell?.configureCell(model: self.arrProduct[indexpath.row],row : indexpath.row)
            
            }, aRowSelectedListener: {[unowned self] (indexPath) in
                let productId = /self.arrProduct[indexPath.row].id
                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
                vc.productId = productId
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, willDisplayCell: {(indexPath) in
                
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewSearchItem.reloadData()
    }
    
    func updateLikeData(model : Item?,index : Int) {
        arrProduct[index] = model ?? Item()
        configureCollectionView()
    }
    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Items")
    }
    
    
}
