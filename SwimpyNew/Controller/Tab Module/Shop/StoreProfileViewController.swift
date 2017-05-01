//
//  StoreProfileViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/7/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
protocol StoreProfileDelegate{
    func getUpdateFollowData(model: StoreDetail)
}
class StoreProfileViewController: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var collectionViewstoreProducts: UICollectionView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var viewNavBar: UIView!
    
    //MARK:- variables
    var sellerId = ""
    var model : StoreDetail?
    var arrProductData : [StoreProducts] = []
    var pageNo : String?
    var delegate: StoreProfileDelegate?
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
        lblStoreName.isHidden = true
        viewNavBar.backgroundColor = UIColor.clear
        pageNo = L10n._0.string
        hitApiForStoreDetail()
    }
    func hitApiForStoreDetail() {
        //API hit for getting Store Details selected by the user
        ApiManager().getDataOfURL(withApi: API.GetStoreDetail(APIParameters.GetStoreDetail(sellerId: sellerId,pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.model = (model as? StoreDetail) ?? StoreDetail()
                self.lblStoreName.text = self.model?.storeName
                self.pageNo = self.model?.pageNo
                for item in self.model?.productData ?? []{
                    self.arrProductData.append(item)
                }
                self.model?.productData = self.arrProductData
                self.configureCollectionView()
            }, method: Keys.Get.rawValue, loader: true)
    }

    
    //MARK:- configure tableview and collection view
    func configureCollectionView(){
        collectionViewdataSource = StoreProfileCollectionViewDataSource(colectionView: collectionViewstoreProducts, datasource: model ?? StoreDetail(), vc: self,pageNo : pageNo)
        collectionViewdataSource?.delegate = self
        collectionViewdataSource?.delegateNavBar = self
        collectionViewstoreProducts.reloadData()
    }
    
    //MARK:- BUTTON ACTIONS
    @IBAction func btnActionBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnActionSearch(_ sender: AnyObject) {
        //        let VC = StoryboardScene.Main.instantiateSearchViewController()
        //        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnActionCart(_ sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateCartViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

//MARK:- delegate functions

extension StoreProfileViewController : StoreProfileTask {
    
    func updateFollowData(model: StoreDetail?, index: Int) {
        guard let temp = model else { return }
        self.model =  temp
        self.delegate?.getUpdateFollowData(model: self.model ?? StoreDetail())
        configureCollectionView()
    }
    func redirectToMessageScreen() {
        let VC = StoryboardScene.Main.instantiateMessageViewController()
        VC.storeId = model?.id
        VC.storeImage = model?.profilePicURLThumbnail
        navigationController?.pushViewController(VC, animated: true)
    }
}
extension StoreProfileViewController : StoreProductTask {
    
    func updateLikeData(model : StoreProducts?, index : Int) {
        guard let temp = model else { return }
        self.model?.productData[index] =  temp
        configureCollectionView()
    }
}

extension StoreProfileViewController : NavBar {
    
    func setNavBarVisible(color : UIColor) {
        viewNavBar.backgroundColor = color
        if color == UIColor.clear {
            lblStoreName.isHidden = true
        }else {
            lblStoreName.isHidden = false
        }
    }
}

extension StoreProfileViewController : StoreProfileCollectionViewTask {
    
    func redirectToProductDetail(productId : String) {
        let vc = StoryboardScene.Main.instantiateProductDetailViewController()
        vc.productId = productId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func hitApiAgain() {
        hitApiForStoreDetail()
    }
}
