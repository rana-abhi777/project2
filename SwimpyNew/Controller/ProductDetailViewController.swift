//
//  ProductDetailViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    
    @IBOutlet weak var collectionViewProductImages: UICollectionView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var tableViewProductDetail: UITableView!
    
    var productId : String = ""
    var productDetails : ProductDetail?
//    var tableDataSource : tableDataSource?
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
    
    func configureTableView() {
        tableDataSource = ProductDetailTableDataSource(tableView: tableViewProductDetail, datasource: productDetails ?? ProductDetail())
        tableViewProductDetail.reloadData()
    }
    
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrOtherImages, collectionView: collectionViewProductImages, cellIdentifier: CellIdentifiers.ProductImagesCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: collectionViewProductImages.frame.size.height, cellWidth: collectionViewProductImages.frame.size.width, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? ProductImagesCollectionViewCell
            
            cell?.configureCell(model: self.arrOtherImages[indexpath.row])
            }, aRowSelectedListener: {[unowned self] (indexPath) in
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewProductImages.reloadData()
    }

    @IBAction func btnActionCart(_ sender: AnyObject) {
    }
    @IBAction func btnActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
