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
    
    @IBOutlet weak var txtCountryName: UITextField!
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    @IBOutlet var lblTitle: UILabel!
    
    var delegate : SendData?
    var arrCountryData : [CountryData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dict = NSMutableArray(contentsOfFile: Bundle.main.path(forResource: "CallingCodes", ofType: "plist")!)!
        arrCountryData =  CountryData.changeDictToModelArray(jsoon1: dict)
        tableView.reloadData()
    }
    
    @IBAction func actionBtnBack(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
}

extension CountryPickerViewController : UITableViewDataSource , UITableViewDelegate {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as? CountryCell else { return UITableViewCell() }
        cell.labelCountryName.text = arrCountryData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCountryData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.setCountryCode(name: arrCountryData[indexPath.row].name ?? "",code : arrCountryData[indexPath.row].code ?? "" )
        let  _ = navigationController?.popViewController(animated: true)
    }
    
}


extension CountryPickerViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        return true
    }
    
}


