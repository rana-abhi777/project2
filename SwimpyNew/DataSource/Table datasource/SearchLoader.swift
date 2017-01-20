//
//  SearchLoader.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/20/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class SearchLoader: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:- variables
    
    var tableView:UITableView?
    
    //MARK:- initializer
    init(tableView: UITableView ) {
        self.tableView = tableView
    }
    
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.SearchLoaderTableViewCell.rawValue) as? SearchLoaderTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
