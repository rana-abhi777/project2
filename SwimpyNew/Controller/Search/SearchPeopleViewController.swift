//
//  SearchPeopleViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/8/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire

class SearchPeopleViewController: UIViewController, IndicatorInfoProvider {
    
    //MARK:- outlets
    @IBOutlet weak var tableViewSearchPeople: UITableView!
    
    //MARK:- variable
    var text = ""
    var timer = Timer()
    var arrUserData : [UserSearchResult] = []
    var tableViewDataSource : TableViewCustomDatasource?
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !Alamofire.NetworkReachabilityManager()!.isReachable {
            timer.invalidate()
            return
        }else {
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SearchPeopleViewController.hitApiToGetSearchResult), userInfo: nil, repeats: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    //MARK:- function
     func hitApiToGetSearchResult() {
        if text == "" {
            return
        }
        ApiManager().getDataOfURL(withApi: API.GetSearchAll(APIParameters.GetSearchAll(text: text, value: "user").formatParameters()), failure: { (err) in
            print(err)
            }, success: { (model) in
                guard let data = model as? SearchResult else { return }
                self.arrUserData = data.dataUser ?? []
                self.configureTableView()
                print(model)
            }, method: "GET", loader: false)
    }
    
    func configureTableView() {
        tableViewDataSource = TableViewCustomDatasource(items: arrUserData, height: 96, estimatedHeight: 96, tableView: tableViewSearchPeople, cellIdentifier: CellIdentifiers.SearchPeopleTableViewCell.rawValue, configureCellBlock: {[unowned self] (cell, item, indexpath) in
            let cell = cell as? SearchPeopleTableViewCell
            cell?.configureCell(model: self.arrUserData[indexpath.row])
            }, aRowSelectedListener: { (indexPath) in
            }, willDisplayCell: { (indexPath) in
                
        })
        tableViewSearchPeople.delegate = tableViewDataSource
        tableViewSearchPeople.dataSource = tableViewDataSource
        tableViewSearchPeople.reloadData()
    }
    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "People")
    }
    
}
