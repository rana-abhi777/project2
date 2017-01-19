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
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !Alamofire.NetworkReachabilityManager()!.isReachable {
            timer.invalidate()
            return
        }else {
            timer =   Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SearchItemViewController.hitApiToGetSearchResult), userInfo: nil, repeats: true)
        }
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
            return
        }
        ApiManager().getDataOfURL(withApi: API.GetSearchAll(APIParameters.GetSearchAll(text: text, value: "item").formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                guard let data = model as? SearchResult else { return }
                self.arrProduct = data.dataitem ?? []
                self.configureCollectionView()
                print(model)
            }, method: "GET", loader: false)
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewSearchItem, cellIdentifier: CellIdentifiers.SearchItemCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewSearchItem.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? SearchItemCollectionViewCell
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
