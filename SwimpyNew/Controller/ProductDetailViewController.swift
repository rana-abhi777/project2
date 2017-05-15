//
//  ProductDetailViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import MIBadgeButton_Swift

class ProductDetailViewController: BaseViewController {
    
    //MARK:- outlets
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var collectionViewProductImages: UICollectionView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var tableViewProductDetail: UITableView!
    @IBOutlet weak var pageControlImage: UIPageControl!
    @IBOutlet weak var viewNavBar: UIView!
    @IBOutlet weak var btnCart: MIBadgeButton!
    
    //MARK:- variables
    var productId : String = ""
    private var lastContentOffset: CGFloat = 0
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
    
    //MARK:- override function
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControlImage.isHidden = true
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        viewCartCount(btnCart: btnCart)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- FUNCTION
    
    func initialize() {
        lblProductName.isHidden = true
        hitApiForProductDetail()
    }
    
    func hitApiForProductDetail() {
        
        ApiManager().getDataOfURL(withApi: API.ProductDetail(APIParameters.ProductDetail(productId: productId).formatParameters()), failure: { (err) in
            print(err)
            
            }, success: {[unowned self] (model) in
                self.productDetails =  (model as? ProductDetail)
                self.arrOtherImages = (self.productDetails?.otherImage)!
                self.configureCollectionView()
                self.configureTableView()
                if self.arrOtherImages.count > 1 {
                    self.pageControlImage.isHidden = false
                    self.pageControlImage.currentPage = 0
                    self.pageControlImage.pageIndicatorTintColor = UIColor.gray
                    self.pageControlImage.currentPageIndicatorTintColor = UIColor.white
                    self.pageControlImage.currentPage = 0
                    self.pageControlImage.numberOfPages = self.arrOtherImages.count
                }
                
            }, method: Keys.Get.rawValue, loader: true)
    }
    
    
    //MARK:- configure tableview and collection view
    func configureTableView() {
        
        tableDataSource = ProductDetailTableDataSource(tableView: tableViewProductDetail, datasource: productDetails ?? ProductDetail(),vc: self)
        tableDataSource?.delegate = self
        tableViewProductDetail.reloadData()
    }
    
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrOtherImages, collectionView: collectionViewProductImages, cellIdentifier: CellIdentifiers.ProductImagesCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: collectionViewProductImages.frame.size.height, cellWidth: collectionViewProductImages.frame.size.width, cellSpacing: 0, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            
            let cell = cell as? ProductImagesCollectionViewCell
            cell?.productImages = self.arrOtherImages[indexpath.row]
            }, aRowSelectedListener: { (indexPath) in
                
            }, willDisplayCell: { (indexPath) in
                
            }, scrollViewListener: { [unowned self] (UIScrollView) in
                let width = self.collectionViewProductImages.frame.width
                let page = self.collectionViewProductImages.contentOffset.x / width
                self.pageControlImage.currentPage = Int(page)
            })
        
        collectionViewProductImages.reloadData()
    }
    
    //MARK:- button actions
    @IBAction func btnActionCart(_ sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateCartViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnActionBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- delegate function related product and more product

extension ProductDetailViewController : RelatedProductsDelegateFunction ,MoreProductsDelegateFunction {
    
    func redirectToProductDetail(productId : String) {
        let vc = StoryboardScene.Main.instantiateProductDetailViewController()
        vc.productId = productId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateFollowingData(data : ProductDetail?) {
        guard let model = data else { return }
        productDetails = model
        configureTableView()
    }
    
    func openThisStore(sellerId : String) {
        let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
        vc.sellerId = sellerId
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK:- delegate function to set nav bar color

extension ProductDetailViewController : NavBarColor {
    func setNavBarColor(color : UIColor) {
        if color == UIColor.white {
            lblProductName.isHidden = false
            lblProductName.text = /productDetails?.productName
            view.bringSubview(toFront: viewNavBar)
        }
        else {
            lblProductName.isHidden = true
            lblProductName.text = ""
        }
        viewNavBar?.backgroundColor = color
    }
}

//MARK:- delegate function product task

extension ProductDetailViewController : ProductDetailTask {
    func redirectToCart(model : ProductDetail?) {
        if model?.maxQuantity == 0 {
            UserFunctions.showAlert(message: L10n.productIsOutOfStock.string)
            return
        }
        else if model?.quantity == 0{
            UserFunctions.showAlert(title: Keys.oops.rawValue, message: Keys.outOfStock.rawValue, type: "info")
        }
        else{
        ApiManager().getDataOfURL(withApi: API.AddToCart(APIParameters.AddToCart(productId: model?.id,variations : model?.sizeSelected,color: model?.colorSelected).formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                UserFunctions.showAlert(title : L10n.success.string, message: L10n.productAddedToCart.string)
                self.viewCartCount(btnCart: self.btnCart)
            }, method: Keys.Post.rawValue, loader: true)
        }
    }
    
    func updateLikeData(model : ProductDetail?) {
        guard let temp = model else { return }
        productDetails = temp
        configureTableView()
    }
    
    func openStore(sellerId : String) {
        let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
        vc.sellerId = sellerId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func buyNow(model : ProductDetail?) {
        if model?.quantity == 0{
            UserFunctions.showAlert(title: Keys.oops.rawValue, message: Keys.outOfStock.rawValue, type: "info")
        }
        else{
        let cartObj = CartData()
        cartObj.imageThumbnail = model?.imageThumbnail
        cartObj.imageOriginal = model?.imageOriginal
        cartObj.total_price = "\(model?.total_price ?? 0.0)"
        cartObj.productId = model?.id
        cartObj.createrId = model?.createrId
        cartObj.parentSupplierId = model?.parentSupplierId ?? ""
        cartObj.productName = model?.productName
        cartObj.shippingPrice = Int(model?.shippingPrice ?? 0)
        cartObj.colorSelected = model?.colorSelected ?? ""
        cartObj.sizeSelected = model?.sizeSelected ?? ""
        
        let VC = StoryboardScene.Main.instantiateAddressDetailsViewController()
        VC.arrCartData = [cartObj]
        self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}

