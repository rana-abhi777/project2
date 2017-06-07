//
//  CategoryProductsViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/24/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class CategoryProductsViewController: UIViewController {
    
    //MARK:- variables
    var categoryId : String?
    var categoryName = ""
    var arrProduct : [Products] = []
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewCategoryProducts.dataSource = collectionViewdataSource
            collectionViewCategoryProducts.delegate = collectionViewdataSource
        }
    }
    var pageNo : String?
    let refreshControl = UIRefreshControl()
    var arrSubCategory : [SubCategory]?
    var creatorId : String?
    var isLoadMore = false
    var flagRefine = false
    var refineParams : OptionalDictionary = nil
    
    var dataFilter = [L10n.price.string, L10n.color.string, L10n.subCategory.string]
    var filterValue : [String] = []
    var sortValue : [String] = []
    var dataSort = [L10n.popular.string, L10n.newest.string, L10n.priceLowToHigh.string , L10n.priceHighToLow.string]
    var colorSelected : [String] = []
    
    
    
    
    //MARK:- outlets
    @IBOutlet weak var collectionViewCategoryProducts: UICollectionView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var viewNoProducts: UIView!
    
    //MARK:- override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handlePagination()
        refreshControl.addTarget(self, action: #selector(CategoryProductsViewController.setup), for: UIControlEvents.valueChanged)
        collectionViewCategoryProducts?.refreshControl =  refreshControl
        setup()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- functions
    
    func resetNoMoreData(){
        self.collectionViewCategoryProducts.es_resetNoMoreData()
    }
    
    func foundNoMoreData(){
        self.collectionViewCategoryProducts.es_stopLoadingMore()
        self.collectionViewCategoryProducts.es_noticeNoMoreData()
    }
    
    func setup() {
        resetNoMoreData()
        pageNo = L10n._0.string
        arrProduct = []
        //configureCollectionView()
        lblCategoryName.text = categoryName
        hitApiForCategory()
    }
    
    
    func handlePagination(){
        let _ = collectionViewCategoryProducts.es_addInfiniteScrolling { [unowned self] in
            if self.pageNo != "" {
                if self.flagRefine {
                    self.getRefinedData()
                }else {
                    self.hitApiForCategory()
                }
            }else{
                self.foundNoMoreData()
            }
            
        }
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewCategoryProducts, cellIdentifier: CellIdentifiers.DealsCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewCategoryProducts.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            
            let cell = cell as? DealsCollectionViewCell
            cell?.delegate = self
            if self.arrProduct.count > 0{
            cell?.configureCell(model: self.arrProduct[indexpath.row],row : indexpath.row)
            }
            }, aRowSelectedListener: { (indexPath) in
                let productId = self.arrProduct[indexPath.row].id ?? ""
                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
                vc.productId = productId
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, willDisplayCell: {(indexPath) in
                
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewCategoryProducts.reloadData()
    }
    
    
    func hitApiForCategory() {
        ApiManager().getDataOfURL(withApi: API.GetCategoryResults(APIParameters.GetCategoryResults(categoryId: categoryId,pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                guard let temp = model  as? ProductResponse else { return }
                let response = temp
                self.arrSubCategory = []
                self.pageNo = response.pageNo ?? nil
                self.refreshControl.endRefreshing()
                for item in response.arrProducts {
                    self.arrProduct.append(item)
                }
                self.isLoadMore = response.arrProducts.count > 0
                self.collectionViewCategoryProducts.es_stopLoadingMore()
                self.isLoadMore ? self.collectionViewCategoryProducts.es_resetNoMoreData() : self.collectionViewCategoryProducts.es_noticeNoMoreData()
                if self.arrProduct.count > 0 {
                    self.configureCollectionView()
                    self.view.bringSubview(toFront: self.collectionViewCategoryProducts)
                    self.arrSubCategory = response.arrSubcategory
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoProducts)
                    
                }
                print(model)
            }, method: Keys.Get.rawValue, loader: self.arrProduct.count == 0)
    }
    
    
    
    //MARK:- button actions
    
    @IBAction func btnActionRefineAndSort(_ sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateRefineAndSortViewController()
        VC.arrSubCategory = arrSubCategory
        VC.creatorId = creatorId
        VC.categoryId = categoryId
        VC.delegate = self
        VC.myDelegate = self
        VC.dataFilter = self.dataFilter
        VC.filterValue = self.filterValue
        VC.dataSort = self.dataSort
        VC.colorSelected = self.colorSelected
        VC.sortValue = self.sortValue
        
        
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}

extension CategoryProductsViewController : SendRefineParameters {
    
    func sendParameters(param : OptionalDictionary) {
        refineParams = param
        resetNoMoreData()
        pageNo = L10n._0.string
        arrProduct = []
        configureCollectionView()
        getRefinedData()
        
    }
    
    func  getRefinedData() {
        ApiManager().getDataOfURL(withApi: API.RefineAndSort(refineParams), failure: { (err) in
            print(err)
            
            }, success: {[unowned self] (model) in
                self.flagRefine = true
                guard let temp = model  as? ProductResponse else { return }
                let response = temp
                self.arrSubCategory = []
                self.pageNo = response.pageNo ?? nil
                self.refreshControl.endRefreshing()
                for item in response.arrProducts {
                    self.arrProduct.append(item)
                }
                self.isLoadMore = response.arrProducts.count > 0
                self.collectionViewCategoryProducts.es_stopLoadingMore()
                self.isLoadMore ? self.collectionViewCategoryProducts.es_resetNoMoreData() : self.collectionViewCategoryProducts.es_noticeNoMoreData()
                if self.arrProduct.count > 0 {
                    self.configureCollectionView()
                    self.view.bringSubview(toFront: self.collectionViewCategoryProducts)
                    self.arrSubCategory = response.arrSubcategory
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoProducts)
                    
                }
                print(model)
            }, method: Keys.Get.rawValue, loader: true)
        
    }
}


//MARK:- DELEGATE function
extension CategoryProductsViewController : DealsProductTask{
    
    func updateLikeData(model : Products?,index : Int) {
        arrProduct[index] = model ?? Products()
        configureCollectionView()
    }
    
    
}

extension CategoryProductsViewController: RefineFilterDelegate{
    func getAllFilters(dataFilter: [String], dataSort: [String], sortValue: [String], filterValue: [String], colorSelected: [String]) {
        self.dataFilter = dataFilter
        self.filterValue = filterValue
        self.dataSort = dataSort
        self.colorSelected = colorSelected
        self.sortValue = sortValue
        print("Values : ")
        print(dataFilter)
        print(filterValue)
        print(dataSort)
        print(colorSelected)
        print(sortValue)
        
    }
}


