//
//  ChatDataSource.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 4/10/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class ChatDataSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- variables
    
    var tableView:UITableView?
    var datasource : [Message]?
    var vc : UIViewController?
    var count : Int = 0
    var storeImage : String?
    
    //MARK:- initializer
    init(tableView: UITableView ,  datasource : [Message], vc : UIViewController,storeImage : String?) {
        self.tableView = tableView
        self.datasource = datasource
        self.vc = vc
        self.storeImage = storeImage
    }
    
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource?.count ?? 0
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = self.datasource?[indexPath.row] else { return UITableViewCell() }
        
        if self.datasource?[indexPath.row].receiverId == MMUserManager.shared.loggedInUser?.id {
            
            //load sender cells
            
            if self.datasource?[indexPath.row].imgOriginal != nil && self.datasource?[indexPath.row].imgOriginal != "" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.SenderImageTableViewCell.rawValue) as? SenderImageTableViewCell else { return UITableViewCell() }
                cell.configureCell(data : data, storeImage : storeImage)
                return cell
                
            }else {
                guard  let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.SenderTextTableViewCell.rawValue) as? SenderTextTableViewCell else { return UITableViewCell() }
                cell.configureCell(data : data, storeImage : storeImage)
                return cell
            }
            
        }else {
            
            //load user cells
            
            if  self.datasource?[indexPath.row].imgOriginal != nil && self.datasource?[indexPath.row].imgOriginal != "" {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.UserChatImageTableViewCell.rawValue) as? UserChatImageTableViewCell else { return UITableViewCell() }
                cell.configureCell(data :data)
                return cell
                
            }else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.UserChatTextTableViewCell.rawValue) as? UserChatTextTableViewCell else { return UITableViewCell()}
                cell.configureCell(data : data)
                return cell
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.datasource?[indexPath.row].imgOriginal != nil && self.datasource?[indexPath.row].imgOriginal != "" {
            return 161
        }else {
            return 48
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.datasource?[indexPath.row].imgOriginal != nil && self.datasource?[indexPath.row].imgOriginal != "" {
            return 161
        }else {
            return UITableViewAutomaticDimension
        }
        
    }
    
    
}
