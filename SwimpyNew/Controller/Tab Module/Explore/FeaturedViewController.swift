//
//  FeaturedViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import EZSwiftExtensions

class FeaturedViewController: BaseViewController,IndicatorInfoProvider {
    
    //MARK:- outlets
    @IBOutlet weak var tableViewFeaturedProducts: UITableView!
    @IBOutlet weak var viewNoProducts: UIView!
    
    //MARK:- variables
    var arrFeaturedData : [Products] = []
    var tableViewDataSource : TableViewCustomDatasource?
    var pageNo : String?
    let refreshControl = UIRefreshControl()
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(FeaturedViewController.setup), for: UIControlEvents.valueChanged)
        tableViewFeaturedProducts?.refreshControl =  refreshControl
        //setup()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setup()
    }
    
    //MARK:- FUNCTION
    func setup() {
        pageNo = L10n._0.string
        arrFeaturedData = []
        apiToGetFeaturedData()
    }
    
    func apiToGetFeaturedData() {
        ApiManager().getDataOfURL(withApi: API.GetFeaturedProduct(APIParameters.GetFeaturedProduct(pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
            }, success: { [unowned self] (model) in
                self.refreshControl.endRefreshing()
                let response = model as? ProductResponse ?? ProductResponse()
                self.pageNo = response.pageNo ?? nil
                for item in response.arrProducts {
                    self.arrFeaturedData.append(item)
                }
                if self.arrFeaturedData.count > 0 {
                    self.configureTableView()
                    self.view.bringSubview(toFront: self.tableViewFeaturedProducts)
                }
                else {
                    self.view.bringSubview(toFront: self.viewNoProducts)
                }
            }, method: Keys.Get.rawValue, loader: false)
    }
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrFeaturedData, height: 400 , estimatedHeight: 400, tableView: tableViewFeaturedProducts, cellIdentifier: CellIdentifiers.FeaturedTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            
            let cell = cell as? FeaturedTableViewCell
            cell?.delegate = self
            if self.arrFeaturedData.count > 0{
            cell?.configureCell(model: self.arrFeaturedData[indexpath.row],row : indexpath.row)
            }
            }, aRowSelectedListener: { (indexPath) in
                
            }, willDisplayCell: {[unowned self] (indexPath) in
                if let temp = self.pageNo,temp != "" ,indexPath.row == self.arrFeaturedData.count - 2   {
                    self.apiToGetFeaturedData()
                }
            })
        tableViewFeaturedProducts.delegate = tableViewDataSource
        tableViewFeaturedProducts.dataSource = tableViewDataSource
        tableViewFeaturedProducts.reloadData()
    }
    
    //MARK:- IndicatorInfoProvider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: Keys.featured.rawValue)
    }
}


//MARK:- DELEGATE FUNCTION

extension FeaturedViewController : FeaturedProductsTask {
    
    func updateLikeData(model : Products?,index : Int) {
        guard let temp = model else { return }
        arrFeaturedData[index] = temp
        configureTableView()
    }
    
    func shareProduct(model : Products?, index : Int) {
        
        self.showActivityViewController(text: "Check out this product on Swimpy -" , img: UIImage(), viewController: self, productId : model?.id)
        
    }
    func buyProduct(model : Products?, index : Int) {
        let cartObj = CartData()
        cartObj.imageThumbnail = model?.productImageThumbnail
        cartObj.imageOriginal = model?.productImageOriginal
        cartObj.total_price = model?.base_price_unit 
        cartObj.productId = model?.id
        cartObj.createrId = model?.createrId
        cartObj.parentSupplierId = model?.parentSupplierId ?? ""
        cartObj.productName = model?.productName
        cartObj.shippingPrice = 0
        cartObj.colorSelected = model?.color?[0] ?? ""
        cartObj.sizeSelected = model?.size?[0] ?? ""
        let VC = StoryboardScene.Main.instantiateAddressDetailsViewController()
        VC.arrCartData = [cartObj]
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    func cellSelected(index : Int ) {
        let productId = /self.arrFeaturedData[index].id
        let vc = StoryboardScene.Main.instantiateProductDetailViewController()
        vc.productId = productId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
