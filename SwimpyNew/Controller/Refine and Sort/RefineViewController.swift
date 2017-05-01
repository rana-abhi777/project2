//
//  RefineViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 2/1/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
protocol SendValue {
    func sendFilterValue(str : String, row : Int)
}

class RefineViewController: UIViewController {
    
    @IBOutlet weak var tableViewRefine: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var tableViewDataSource : TableViewCustomDatasource?
    var value : Int = 0
    var arrChoice : [String] = []
    var delegate : SendValue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getData() {
        switch value {
        case SwitchValues.zero.rawValue :
            lblTitle.text = L10n.price.string
            arrChoice =  [L10n.anyPrice.string ,L10n._120.string,L10n._21100.string,L10n._101200.string,L10n._201500.string,L10n._501.string]
        case SwitchValues.one.rawValue:
            lblTitle.text = L10n.color.string
            arrChoice = [L10n.red.string , L10n.pink.string, L10n.purple.string, L10n.blue.string, L10n.skyblue.string,L10n.green.string,L10n.yellow.string,L10n.orange.string,L10n.brown.string,L10n.black.string,L10n.white.string,L10n.silver.string,L10n.gold.string, L10n.gray.string]
        default :
            lblTitle.text = L10n.subCategory.string
           // arrChoice = ["get category from backend"]
            
        }
    }
    
    func configureTableView() {
        
        tableViewDataSource = TableViewCustomDatasource(items: arrChoice as Array<AnyObject>?, height: 40, estimatedHeight: 40, tableView: tableViewRefine, cellIdentifier: CellIdentifiers.SortTableViewCell.rawValue, configureCellBlock: { [unowned self] (cell, item, indexpath) in
            guard let cell = cell as? SortTableViewCell else { return }
            cell.lblValue.isHidden = true
            cell.lblCategory.text = self.arrChoice[indexpath.row]
            cell.imgTick.isHidden = true
            
            }, aRowSelectedListener: {[unowned self] (indexPath) in
                self.delegate?.sendFilterValue(str: self.arrChoice[indexPath.row], row : indexPath.row)
                _ = self.navigationController?.popViewController(animated: true)
                
            }, willDisplayCell: { (indexPath) in
                
        })
        
        tableViewRefine.delegate = tableViewDataSource
        tableViewRefine.dataSource = tableViewDataSource
        tableViewRefine.reloadData()
    }
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
