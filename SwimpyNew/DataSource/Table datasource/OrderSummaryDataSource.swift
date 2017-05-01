//
//  OrderSummaryDataSource.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 3/1/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class OrderSummaryDataSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- variables
    
    var tableView:UITableView?
    var datasource : [OrderDetail]?
    var vc : UIViewController?
    var address : DefaultAddress?
    var count : Int = 0
    var totalAmt : Double?
    var shippingCost : Double?
    
    //MARK:- initializer
    init(tableView: UITableView ,  datasource : [OrderDetail], address : DefaultAddress? ,totalAmt : Double?,shippingCost : Double?, vc : UIViewController) {
        self.tableView = tableView
        self.datasource = datasource
        self.vc = vc
        self.address = address
        self.totalAmt = totalAmt
        self.shippingCost = shippingCost
        self.count = datasource.count + 2
    }
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < count-2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.OrderDetailTableViewCell.rawValue) as? OrderDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(model: datasource?[indexPath.row] ?? OrderDetail())
            
            return cell
        }
        else if indexPath.row == count-2  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.PriceDetailTableViewCell.rawValue) as? PriceDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.lblTotalPrice.text = "$ " + "\(/totalAmt )"
            cell.lblShippingPrice.text = "$ " + "\(/shippingCost)"
            cell.lblNetTotalAmount.text = "$ " + "\(/totalAmt + /shippingCost)"
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.AddressTableViewCell.rawValue) as? AddressTableViewCell else {
                return UITableViewCell()
            }
            guard let data = address else { return cell }
            cell.configureCell(model: data)
            cell.delegate = self.vc as? OrderDetailViewController
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < count-2 {
            return 81
        }else if indexPath.row == count-2   {
            return 150
        }else {
            return 208
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < count-2 {
            return 81
        }else if indexPath.row == count-2   {
            return 150
        }else {
            return UITableViewAutomaticDimension
        }

        
    }
    
}
