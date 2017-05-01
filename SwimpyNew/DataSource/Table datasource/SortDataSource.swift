//
//  SortDataSource.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 2/1/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

protocol FilterData {
    func getFilterValue(value : Int)
    func getSortValue(row : Int)
}

class SortDataSource: NSObject {
    
    //MARK:- variables
    
    var tableView:UITableView?
    var dataFilter : [String]?
    var vc : UIViewController?
    var dataSort : [String]?
    var headerData = ["REFINE", "SORT BY"]
    var delegate : FilterData?
    var sortValue : [String]?
    var filterValue : [String]?
    var colorSelected : [String]?
    var strcolorSelected : String = ""
    
    //MARK:- initializer
    init(tableView: UITableView ,  dataFilter : [String],dataSort: [String],sortValue : [String], filterValue : [String], vc : UIViewController, colorSelected : [String]) {
        self.tableView = tableView
        self.dataFilter = dataFilter
        self.vc = vc
        self.dataSort = dataSort
        self.sortValue = sortValue
        self.filterValue = filterValue
        self.colorSelected = colorSelected
        
        self.strcolorSelected = colorSelected.joined(separator: ", ")
    }
    override init() {
        super.init()
    }
}

extension SortDataSource : UITableViewDelegate , UITableViewDataSource{
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section ==  SwitchValues.zero.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.SortTableViewCell.rawValue) as? SortTableViewCell else {
                return UITableViewCell()
            }
            cell.lblCategory.text = dataFilter?[indexPath.row]
            cell.imgTick.isHidden = true
            if indexPath.row == SwitchValues.one.rawValue {
                cell.lblValue.text = strcolorSelected
            }else {
            cell.lblValue.text = filterValue?[indexPath.row]
            }
            if filterValue?[indexPath.row] == "" {
                cell.lblValue.isHidden = true
            }else {
                 cell.lblValue.isHidden = false
            }
           
            return cell
        }
        else  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.SortTableViewCell.rawValue) as? SortTableViewCell else {
                return UITableViewCell()
            }
            cell.lblCategory.text = dataSort?[indexPath.row]
            cell.lblValue.isHidden = true
            if sortValue?[indexPath.row] == "1" {
                cell.imgTick.isHidden = false
                cell.lblCategory.textColor = UIColor.lblColorEnable()
            }
            else {
                cell.lblCategory.textColor = UIColor.lblColorDisable()
                cell.imgTick.isHidden = true
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case SwitchValues.zero.rawValue :
            var value = SwitchValues.zero.rawValue
            switch indexPath.row {
            case SwitchValues.zero.rawValue:   //price
                value = SwitchValues.zero.rawValue
                
            case SwitchValues.one.rawValue:   //color
                value = SwitchValues.one.rawValue
                
            default: //category.
                value = SwitchValues.two.rawValue
                
            }
            self.delegate?.getFilterValue(value: value)
        case 1:
            self.delegate?.getSortValue(row: indexPath.row)
       
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.dataFilter?.count ?? 0
        }else {
            return self.dataSort?.count ?? 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerData.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.SortHeaderTableViewCell.rawValue) as? SortHeaderTableViewCell else { return UIView() }
        header.lblHeaderTitle.text = headerData[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 48
    }
    
}


