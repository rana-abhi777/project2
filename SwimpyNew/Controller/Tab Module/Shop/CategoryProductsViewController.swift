//
//  CategoryProductsViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/24/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class CategoryProductsViewController: UIViewController, CategoryProductsTask {
    
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
    
    //MARK:- outlets
    @IBOutlet weak var collectionViewCategoryProducts: UICollectionView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var viewNoProducts: UIView!
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- functions
    func initialize() {
        lblCategoryName.text = categoryName
        hitApiForCategory()
    }
    
    func configureCollectionView(){
        collectionViewdataSource = CollectionViewDataSource(items: arrProduct, collectionView: collectionViewCategoryProducts, cellIdentifier: CellIdentifiers.CategoryProductsCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (collectionViewCategoryProducts.frame.size.width - 8)/2, cellSpacing: 8, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? CategoryProductsCollectionViewCell
            cell?.layer.cornerRadius = 4.0
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
            cell?.delegate = self
            cell?.configureCell(model: self.arrProduct[indexpath.row],row : indexpath.row)
            }, aRowSelectedListener: { (indexPath) in
                let productId = self.arrProduct[indexPath.row].id ?? ""
                let vc = StoryboardScene.Main.instantiateProductDetailViewController()
                vc.productId = productId
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, willDisplayCell: {[unowned self] (indexPath) in
                
                
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewCategoryProducts.reloadData()
    }
    
    
    func hitApiForCategory() {
        ApiManager().getDataOfURL(withApi: API.GetCategoryResults(APIParameters.GetCategoryResults(categoryId: categoryId).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.arrProduct =  (model as? [Products]) ?? []
                if self.arrProduct.count > 0 {
                    self.configureCollectionView()
                    self.view.bringSubview(toFront: self.collectionViewCategoryProducts)
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoProducts)
                    
                }
                print(model)
            }, method: "GET", loader: true)
    }
    
    func updateLikeData(model : Products?,index : Int) {
        arrProduct[index] = model ?? Products()
        configureCollectionView()
    }
    
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
