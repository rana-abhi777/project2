//
//  CountryPickerViewController.swift
//  Glam360
//
//  Created by Aseem 10 on 3/16/17.
//  Copyright © 2017 Gagan. All rights reserved.
//

import UIKit
import EZSwiftExtensions

protocol SendData {
    func setCountryCode(name : String ,code : String)
}

class CountryPickerViewController: UIViewController {
    
    var filteredArray = [CountryData]()
    var delegate : SendData?
    var arrCountryData : [CountryData] = []
    var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var txtCountryName: UITextField!
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    @IBOutlet var lblTitle: UILabel!
       override func viewDidLoad() {
        super.viewDidLoad()
        let dict = NSMutableArray(contentsOfFile: Bundle.main.path(forResource: "CallingCodes", ofType: "plist")!)!
        arrCountryData =  CountryData.changeDictToModelArray(jsoon1: dict)
        tableView.reloadData()
        initializeSearchBar()
    }
    
    @IBAction func actionBtnBack(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
        definesPresentationContext = false
    }
    
}

extension CountryPickerViewController : UITableViewDataSource , UITableViewDelegate {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as? CountryCell else { return UITableViewCell() }
        let county: CountryData
        if searchController.isActive && searchController.searchBar.text! != "" {
            county = filteredArray[indexPath.row]
        }else{
            county = arrCountryData[indexPath.row]
        }
        
        //cell.labelCountryName.text = arrCountryData[indexPath.row].name
        cell.labelCountryName.text = county.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text! != "" {
            return filteredArray.count
        }
        
        return arrCountryData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let county: CountryData
        if searchController.isActive && searchController.searchBar.text! != "" {
            county = filteredArray[indexPath.row]
        }else{
            county = arrCountryData[indexPath.row]
        }
        
        
        //self.delegate?.setCountryCode(name: arrCountryData[indexPath.row].name ?? "",code : arrCountryData[indexPath.row].code ?? "" )
        self.delegate?.setCountryCode(name: /county.name, code: /county.code)
        searchController.isActive = false
        let  _ = navigationController?.popViewController(animated: true)
    }
    
}

extension CountryPickerViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

extension CountryPickerViewController{
    func initializeSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredArray = arrCountryData.filter { country in
            return (country.name?.lowercased().contains(searchText.lowercased()))!
        }
        
        tableView.reloadData()
    }
}
