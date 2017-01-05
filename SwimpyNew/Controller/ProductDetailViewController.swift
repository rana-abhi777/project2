//
//  ProductDetailViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController,RelatedProductsDelegateFunction,MoreProductsDelegateFunction,ProductDetailTask {
    
    //MARK:- outlets
    @IBOutlet weak var collectionViewProductImages: UICollectionView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var tableViewProductDetail: UITableView!
    
    //MARK:- variables
    var productId : String = ""
    var productDetails : ProductDetail?
    var arrOtherImages : [ProductOtherImage] = []
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewProductImages.dataSource = collectionViewdataSource
            collectionViewProductImages.delegate = collectionViewdataSource
        }
    }
    var tableDataSource : ProductDetailTableDataSource?{
        didSet{
            tableViewProductDetail.dataSource = tableDataSource
            tableViewProductDetail.delegate = tableDataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- FUNCTION
    
    func initialize() {
        hitApiForProductDetail()
    }
    
    func hitApiForProductDetail() {
        ApiManager().getDataOfURL(withApi: API.ProductDetail(APIParameters.ProductDetail(productId: productId).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.productDetails =  (model as? ProductDetail)
                print(self.productDetails)
                self.arrOtherImages = (self.productDetails?.otherImage)!
                self.configureCollectionView()
                self.configureTableView()
                //set all the data
                
            }, method: "GET", loader: true)
    }
    
    
    //MARK:- configure tableview and collection view
    func configureTableView() {
        tableDataSource = ProductDetailTableDataSource(tableView: tableViewProductDetail, datasource: productDetails ?? ProductDetail(),vc: self)
        tableViewProductDetail.reloadData()
    }
    
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrOtherImages, collectionView: collectionViewProductImages, cellIdentifier: CellIdentifiers.ProductImagesCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: collectionViewProductImages.frame.size.height, cellWidth: collectionViewProductImages.frame.size.width, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? ProductImagesCollectionViewCell
           
            cell?.configureCell(model: self.arrOtherImages[indexpath.row])
            }, aRowSelectedListener: { (indexPath) in
            }, willDisplayCell: { (indexPath) in
                //
                
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewProductImages.reloadData()
    }
    
    
    //MARK:- delegate function
    func redirectToProductDetail(productId : String) {
        let vc = StoryboardScene.Main.instantiateProductDetailViewController()
        vc.productId = productId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func redirectToCart(model : ProductDetail?) {
        ApiManager().getDataOfURL(withApi: API.AddToCart(APIParameters.AddToCart(productId: model?.id,variations : model?.sizeSelected,color: model?.colorSelected).formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                UserFunctions.showAlert(title : "Success", message: L10n.productAddedToCart.string)
            }, method: "POST", loader: true)
    }
    
    func updateLikeData(model : ProductDetail?) {
        productDetails = model ?? ProductDetail()
        configureTableView()
    }
    func updateFollowingData(data : ProductDetail?) {
        productDetails = data ?? ProductDetail()
        configureTableView()
    }
    func openStore(sellerId : String) {
        let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
        vc.sellerId = sellerId
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    //MARK:- button actions
    @IBAction func btnActionCart(_ sender: AnyObject) {
    }
    @IBAction func btnActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
