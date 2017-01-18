//
//  ProductDetailViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class ProductDetailViewController: BaseViewController,RelatedProductsDelegateFunction,MoreProductsDelegateFunction,ProductDetailTask,NavBarColor {
    
    //MARK:- outlets
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var collectionViewProductImages: UICollectionView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var tableViewProductDetail: UITableView!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var viewCartNotification: UIView!
    @IBOutlet weak var pageControlImage: UIPageControl!
    @IBOutlet weak var viewNavBar: UIView!
    
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
        
        pageControlImage.currentPage = 0
        pageControlImage.pageIndicatorTintColor = UIColor.gray
        pageControlImage.currentPageIndicatorTintColor = UIColor.white
        viewCartCount(viewCartNotification: viewCartNotification,lblCartCount: lblCartCount)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pageControlImage.currentPage = 0
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
                print(self.productDetails)
                self.arrOtherImages = (self.productDetails?.otherImage)!
                self.configureCollectionView()
                self.configureTableView()
                self.pageControlImage.numberOfPages = self.arrOtherImages.count                
            }, method: "GET", loader: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y >= 120 && self.lastContentOffset < scrollView.contentOffset.y   {
            if scrollView.contentOffset.y >= 60 {
                viewNavBar?.backgroundColor = UIColor.white
                lblProductName.isHidden = false
                lblProductName.text = productDetails?.productName ?? ""
            }
        }
        else if self.lastContentOffset > scrollView.contentOffset.y {
            if scrollView.contentOffset.y <= 60 {
                viewNavBar?.backgroundColor = UIColor.clear
                lblProductName.isHidden = true
                lblProductName.text = ""
            }
        }
        lastContentOffset = scrollView.contentOffset.y
    }
    
    //MARK:- configure tableview and collection view
    func configureTableView() {
        tableDataSource = ProductDetailTableDataSource(tableView: tableViewProductDetail, datasource: productDetails ?? ProductDetail(),vc: self)
        tableDataSource?.delegate = self
        tableViewProductDetail.reloadData()
    }
    
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrOtherImages, collectionView: collectionViewProductImages, cellIdentifier: CellIdentifiers.ProductImagesCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: collectionViewProductImages.frame.size.height, cellWidth: collectionViewProductImages.frame.size.width, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? ProductImagesCollectionViewCell
            
            cell?.configureCell(model: self.arrOtherImages[indexpath.row])
            }, aRowSelectedListener: { (indexPath) in
            }, willDisplayCell: { (indexPath) in
                //
                
            }, scrollViewListener: { [unowned self] (UIScrollView) in
                let width = self.collectionViewProductImages.frame.width
                let page = self.collectionViewProductImages.contentOffset.x / width
                self.pageControlImage.currentPage = Int(page)
            })
        collectionViewProductImages.reloadData()
    }
    
    //MARK:- delegate function
    func setNavBarColor(color : UIColor) {
        if color == UIColor.white {
            lblProductName.isHidden = false
            lblProductName.text = productDetails?.productName ?? ""
        }
        else {
            lblProductName.isHidden = true
            lblProductName.text = ""
        }
        viewNavBar?.backgroundColor = color
    }
    
    
    func redirectToProductDetail(productId : String) {
        let vc = StoryboardScene.Main.instantiateProductDetailViewController()
        vc.productId = productId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func redirectToCart(model : ProductDetail?) {
        ApiManager().getDataOfURL(withApi: API.AddToCart(APIParameters.AddToCart(productId: model?.id,variations : model?.sizeSelected,color: model?.colorSelected).formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                UserFunctions.showAlert(title : L10n.success.string, message: L10n.productAddedToCart.string)
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
    func openThisStore(sellerId : String) {
        let vc = StoryboardScene.Main.instantiateStoreProfileViewController()
        vc.sellerId = sellerId
        self.navigationController?.pushViewController(vc, animated: true)
        
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
