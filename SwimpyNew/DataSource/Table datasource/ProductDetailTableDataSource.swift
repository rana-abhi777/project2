//
//  ProductDetailTableDataSource.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/13/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//
protocol NavBarColor {
    func setNavBarColor(color : UIColor)
}

import UIKit

class ProductDetailTableDataSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    
    //MARK:-  variables
    var tableView:UITableView?
    var datasource : ProductDetail?
    var vc : UIViewController?
    private var lastContentOffset: CGFloat = 0
    var delegate : NavBarColor?
    
    //MARK:- initializer
    init(tableView: UITableView ,  datasource : ProductDetail, vc : UIViewController) {
        self.tableView = tableView
        self.datasource = datasource
        self.vc = vc
    }
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.ProductDetailTableViewCell.rawValue) as? ProductDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(model: datasource ?? ProductDetail())
            cell.delegate = (vc as? ProductDetailViewController) ?? nil
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MoreFromStoreTableViewCell.rawValue) as? MoreFromStoreTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(model: datasource ?? ProductDetail())
            cell.delegate = (vc as? ProductDetailViewController) ?? nil
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.RelatedProductsTableViewCell.rawValue) as? RelatedProductsTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(model: datasource ?? ProductDetail())
            cell.delegate = (vc as? ProductDetailViewController) ?? nil
            return cell
        }
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 473
        }else if indexPath.row == 1 {
            return 209
        }
        else {
            return 339
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableViewAutomaticDimension
        }else if indexPath.row == 1 {
            return 209
        }
        else {
            return 339
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 120 && self.lastContentOffset < scrollView.contentOffset.y   {
            if scrollView.contentOffset.y >= 60 {
                self.delegate?.setNavBarColor(color: UIColor.white)
                //                viewNavBar?.backgroundColor = UIColor.white
            }
        }
        else if self.lastContentOffset > scrollView.contentOffset.y {
            if scrollView.contentOffset.y <= 60 {
                self.delegate?.setNavBarColor(color: UIColor.clear)
                //                viewNavBar?.backgroundColor = UIColor.clear
                
            }
        }
        lastContentOffset = scrollView.contentOffset.y
    }
}

