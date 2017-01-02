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
    var datasource : ProductDetail?
    var vc : UIViewController?
    
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
        return 2
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.CartProductDetailTableViewCell.rawValue) as? CartProductDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(model: datasource ?? ProductDetail())
            cell.delegate = (vc as? CartViewController) ?? nil
            return cell
        }
        else   {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.CartPriceDetailTableViewCell.rawValue) as? CartPriceDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(model: datasource ?? ProductDetail())
//            cell.delegate = (vc as? CartViewController) ?? nil
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 171
        }else  {
            return 348
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 171
        }else  {
            return 348
        }
       
    }
    
}
