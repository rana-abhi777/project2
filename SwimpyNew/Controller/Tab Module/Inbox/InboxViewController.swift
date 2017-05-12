//
//  InboxViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import MIBadgeButton_Swift

class InboxViewController: BaseViewController {
    
    //MARK:- outlet
    @IBOutlet weak var btnCart: MIBadgeButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewNoChats: UIView!
    
    var tableViewDataSource : TableViewCustomDatasource?
    var arrChatList : [ChatList] = []
    //  var arrChatList
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewCartCount(btnCart: btnCart)
    }
    override func viewWillAppear(_ animated: Bool) {
        apiToGetGlobalActivity()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func apiToGetGlobalActivity() {
        ApiManager().getDataOfURL(withApi: API.chatList(APIParameters.chatList().formatParameters()), failure: { (err) in
            print(err)
        }, success: {[unowned self] (model) in
            self.arrChatList = model as? [ChatList] ?? []
            print("ArrayChatList : " , self.arrChatList)
            print(self.arrChatList.count)
            if self.arrChatList.count > 0 {
                self.configureTableView()
                self.view.bringSubview(toFront: self.tableView)
            }
            else {
                self.view.bringSubview(toFront: self.viewNoChats)
            }
            
            }, method: Keys.Get.rawValue, loader: true)
        
    }
    
    func configureTableView() {
        
        tableViewDataSource = TableViewCustomDatasource(items: arrChatList, height: 89, estimatedHeight: 89, tableView: tableView, cellIdentifier: CellIdentifiers.InboxChatListTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? InboxChatListTableViewCell
            if self.arrChatList.count > 0{
            cell?.configureCell(data: self.arrChatList[indexpath.row])
            }
            }, aRowSelectedListener: { [unowned self] (indexPath) in
                let VC = StoryboardScene.Main.instantiateMessageViewController()
                VC.storeId = self.arrChatList[indexPath.row].sellerId
                VC.storeImage = self.arrChatList[indexPath.row].imgThumbail
                self.navigationController?.pushViewController(VC, animated: true)
            }, willDisplayCell: { (indexPath) in
        })
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
        tableView.reloadData()
    }
    
    //MARK:- button actions
    @IBAction func btnActionCart(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateCartViewController()
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func btnSearchAction(sender: AnyObject) {
                        let VC = StoryboardScene.Main.searchViewControllerScene.viewController()
                        self.navigationController?.pushViewController(VC, animated: true)
        print(self.arrChatList)
    }
    
}
