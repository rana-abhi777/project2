//
//  CartDataSource.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/31/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class CartDataSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- variables
    
    var tableView:UITableView?
    var datasource : [CartData]?
    var vc : UIViewController?
    var count : Int = 0
    
    //MARK:- initializer
    init(tableView: UITableView ,  datasource : [CartData], vc : UIViewController) {
        self.tableView = tableView
        self.datasource = datasource
        self.vc = vc
        self.count = datasource.count + 1
    }
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < count-1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.CartProductDetailTableViewCell.rawValue) as? CartProductDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(model: datasource?[indexPath.row] ?? CartData(),index : indexPath.row)
            cell.delegate = (vc as? CartViewController) ?? nil
            return cell
        }
        else   {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.CartPriceDetailTableViewCell.rawValue) as? CartPriceDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = (vc as? CartViewController) ?? nil
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < count-1 {
            return 171
        }else  {
            return 56
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < count-1 {
            return 171
        }else  {
            return 56
        }
        
    }
    
}
