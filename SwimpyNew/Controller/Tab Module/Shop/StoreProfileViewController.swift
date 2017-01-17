//
//  StoreProfileViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/7/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class StoreProfileViewController: UIViewController ,StoreProfileTask,StoreProductTask,StoreProfileCollectionViewTask {
    
    //MARK:- outlets
    @IBOutlet weak var collectionViewstoreProducts: UICollectionView!
    
    
    //MARK:- variables
    var sellerId = ""
    var model : StoreDetail?
    var arrProductData : [StoreProducts] = []
    var pageNo : String?
    var collectionViewdataSource : StoreProfileCollectionViewDataSource?{
        didSet{
            collectionViewstoreProducts.dataSource = collectionViewdataSource
            collectionViewstoreProducts.delegate = collectionViewdataSource
        }
    }
    
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- functions
    func initialize() {
        pageNo = L10n._0.string
        hitApiForStoreDetail()
    }
    
    func hitApiForStoreDetail() {
        ApiManager().getDataOfURL(withApi: API.GetStoreDetail(APIParameters.GetStoreDetail(sellerId: sellerId,pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.model = (model as? StoreDetail) ?? StoreDetail()
                
                self.pageNo = self.model?.pageNo
                
                for item in self.model?.productData ?? []{
                    self.arrProductData.append(item)
                }
                self.model?.productData = self.arrProductData
                self.configureCollectionView()
            }, method: "GET", loader: true)
    }
    
    
    //MARK:- configure tableview and collection view
    
    func configureCollectionView(){
        collectionViewdataSource = StoreProfileCollectionViewDataSource(colectionView: collectionViewstoreProducts, datasource: model ?? StoreDetail(), vc: self,pageNo : pageNo)
        collectionViewdataSource?.delegate = self
        collectionViewstoreProducts.reloadData()
    }
    
    
    //MARK:- delegate functions
   
    func sortPressed() {
        let VC = StoryboardScene.Main.instantiateSortViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    func filterPressed() {
        let VC = StoryboardScene.Main.instantiateFilterViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    func openCart() {
        let VC = StoryboardScene.Main.instantiateCartViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    func openSearch() {
//        let VC = StoryboardScene.Main.instantiateSearchViewController()
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    func goBack() {
       _ = self.navigationController?.popViewController(animated: true)
    }
    
    func updateFollowData(model: StoreDetail?, index: Int) {
        self.model =  model ?? StoreDetail()
        configureCollectionView()
    }
    
    func updateLikeData(model : StoreProducts?, index : Int) {
        self.model?.productData[index] =  model ?? StoreProducts()
        configureCollectionView()
    }
    
    func redirectToProductDetail(productId : String) {
        let vc = StoryboardScene.Main.instantiateProductDetailViewController()
        vc.productId = productId
        self.navigationController?.pushViewController(vc, animated: true)
    }
     func hitApiAgain() {
        hitApiForStoreDetail()
    }
}
