//
//  RefineAndSortViewController.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 2/1/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol SendRefineParameters {
    func sendParameters(param : OptionalDictionary)
}


class RefineAndSortViewController: BaseViewController, FilterData,SendValue {
    
    //MARK:- Outlet
    @IBOutlet weak var tableViewSort: UITableView!
    
    
    //MARK:- Variable
    var delegate : SendRefineParameters?
    var tableDataSource : SortDataSource? {
        didSet{
            tableViewSort.dataSource = tableDataSource
            tableViewSort.delegate = tableDataSource
        }
    }
    var value : Int = 0
    var dataFilter = [L10n.price.string, L10n.color.string, L10n.subCategory.string]
    var filterValue : [String] = []
    var sortValue : [String] = []
    var dataSort = [L10n.popular.string, L10n.newest.string, L10n.priceLowToHigh.string , L10n.priceHighToLow.string]
    var arrChoice : [String] = []
    var arrSubCategory : [SubCategory]?
    var sortType : String?
    var subCategorySelected : SubCategory?
    var creatorId : String?
    var categoryId : String?
    var minPrice : String?
    var maxPrice : String?
    
    var colorSelected : [String] = []
    
    //MARK:- Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        filterValue = [String](repeating: "", count:self.dataFilter.count)
        sortValue = [String](repeating: "", count:dataSort.count)
        for item in (arrSubCategory ?? []) {
            arrChoice.append(/item.name )
        }
        configureTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- functions
    func configureTableView() {
        tableDataSource = SortDataSource(tableView: tableViewSort, dataFilter: dataFilter, dataSort: dataSort,sortValue : sortValue, filterValue : filterValue ,vc: self,colorSelected : colorSelected )
        tableDataSource?.delegate = self
        tableViewSort.reloadData()
    }
    
    func getSortValue(row : Int) {
        if sortValue[row] == "1" {
            sortValue[row] = ""
            sortType = "NEW"
        }else {
            sortValue = [String](repeating: "", count:dataSort.count)
            sortValue[row] = L10n._1.string
            // sortType = dataSort[row]
            switch row {
            case SwitchValues.zero.rawValue :
                sortType = "POP"
            case SwitchValues.one.rawValue :
                sortType = "NEW"
            case SwitchValues.two.rawValue :
                sortType = "LH"
            case SwitchValues.three.rawValue :
                sortType = "HT"
            default :
                sortType = "NEW"
            }
        }
        print(sortType)
        configureTableView()
    }
    
    
    //filter values
    func getFilterValue(value : Int) {
        let vc = StoryboardScene.Main.instantiateRefineViewController()
        self.value = value
        vc.value = value
        vc.arrChoice = arrChoice
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sendFilterValue(str : String, row : Int) {
        if value ==  2 {
            //get sub category
            subCategorySelected = arrSubCategory?[row]
            
        }else if value == 0 {
            switch row {
                
                
            case SwitchValues.one.rawValue :
                minPrice = "1"
                maxPrice = "20"
            case SwitchValues.two.rawValue:
                minPrice = "21"
                maxPrice = "100"
            case SwitchValues.three.rawValue:
                minPrice = "101"
                maxPrice = "200"
            case SwitchValues.four.rawValue:
                minPrice = "201"
                maxPrice = "500"
            case SwitchValues.five.rawValue:
                minPrice = "501"
            default :
                break
                
            }
        }else if value == 1 {
            colorSelected.append(str)  //make it unique and send
            colorSelected = removeDuplicateString(values: colorSelected)
        }
        
        filterValue[value] = str
        configureTableView()
    }
    
 
    
    
    func filterSortApi() {
        let optionaldic = APIParameters.RefineAndSort(createrId: creatorId, categoryId: categoryId , subcategoryId: subCategorySelected?.id, pageNo: "0", color: convertArrayIntoJson(array: colorSelected), minPrice: minPrice, maxPrice: maxPrice, sort: sortType).formatParameters()
        
        self.delegate?.sendParameters(param: optionaldic)
        _ = self.navigationController?.popViewController(animated:  true)
    
        
    }
    
    
    //MARK:- button actions
    @IBAction func btnActionBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionApply(_ sender: AnyObject) {
        filterSortApi()
    }
    
    
}
