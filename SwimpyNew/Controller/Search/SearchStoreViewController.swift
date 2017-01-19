//
//  SearchStoreViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire

class SearchStoreViewController: UIViewController , IndicatorInfoProvider {
    
    //MARK:- outlet
    @IBOutlet weak var viewNoStore: UIView!
    @IBOutlet weak var collectionViewSearchStore: UICollectionView!
    
    
    //MARK:- variable
    var text = ""
    var timer = Timer()
    var arrStores : [Store] = []
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewSearchStore.dataSource = collectionViewdataSource
            collectionViewSearchStore.delegate = collectionViewdataSource
        }
    }

    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !Alamofire.NetworkReachabilityManager()!.isReachable {
            timer.invalidate()
            return
        }else {
            timer =   Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SearchStoreViewController.hitApiToGetSearchResult), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    //MARK:- function
    func hitApiToGetSearchResult() {
        if text == "" {
            return
        }
        ApiManager().getDataOfURL(withApi: API.GetSearchAll(APIParameters.GetSearchAll(text: text, value: "store").formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                guard let data = model as? SearchResult else { return }
                self.arrStores = data.dataStore ?? []
                self.configureCollectionView()
            }, method: "GET", loader: false)
    }
    
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrStores, collectionView: collectionViewSearchStore, cellIdentifier: CellIdentifiers.SearchStoreCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 168, cellWidth: (collectionViewSearchStore.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? SearchStoreCollectionViewCell
            cell?.layer.cornerRadius = 4.0
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
            cell?.configureCell(model: self.arrStores[indexpath.row])
            }, aRowSelectedListener: {[unowned self] (indexPath) in
                let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
                vc.sellerId = self.arrStores[indexPath.row].id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, willDisplayCell: {[unowned self] (indexPath) in
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewSearchStore.reloadData()
    }
    

    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Store")
    }
}
