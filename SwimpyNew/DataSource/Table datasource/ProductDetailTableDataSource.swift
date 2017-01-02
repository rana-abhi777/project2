//
//  ProductDetailTableDataSource.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/13/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class ProductDetailTableDataSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var tableView:UITableView?
    var datasource : ProductDetail?
    var vc : UIViewController?
    
    //MARK:- initializer
    init(tableView: UITableView ,  datasource : ProductDetail, vc : UIViewController) {
        self.tableView = tableView
        self.datasource = datasource
        self.vc = vc
    }
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.ProductDetailTableViewCell.rawValue) as? ProductDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(model: datasource ?? ProductDetail())
            cell.delegate = (vc as? ProductDetailViewController) ?? nil
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MoreFromStoreTableViewCell.rawValue) as? MoreFromStoreTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(model: datasource ?? ProductDetail())
            cell.delegate = (vc as? ProductDetailViewController) ?? nil
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.RelatedProductsTableViewCell.rawValue) as? RelatedProductsTableViewCell else {
                return UITableViewCell()
            }
            cell.configureCell(model: datasource ?? ProductDetail())
            cell.delegate = (vc as? ProductDetailViewController) ?? nil
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 473
        }else if indexPath.row == 1 {
            return 209
        }
        else {
            return 339
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableViewAutomaticDimension
        }else if indexPath.row == 1 {
            return 209
        }
        else {
            return 339
        }
    }
    
}
//{
//    var tableViewIngredients : UITableView?
//    var tableViewComments : UITableView?
//    var tableViewSteps : UITableView?
//    var data :RecipeDetails?
//    var delegate : Task?
//
//
//    //MARK:- initializer
//    init(tableViewIngredients: UITableView,tableViewComments : UITableView,tableViewSteps: UITableView,data :RecipeDetails ) {
//        self.tableViewIngredients = tableViewIngredients
//        self.tableViewComments = tableViewComments
//        self.tableViewSteps = tableViewSteps
//        self.data = data
//    }
//
//    override init() {
//        super.init()
//    }
//
//    //MARK :- table view functions
//
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return headerTitle.count
//    }
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView.dequeueReusableCellWithIdentifier("EntriesHeaderTableViewCell") as? EntriesHeaderTableViewCell else { return UIView() }
//        header.lblSectionTitle.text = headerTitle[section]
//        return header
//    }
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return headerTitle[section] as? String ?? ""
//    }
//
//
//
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if tableView ==  tableViewIngredients {
//            return data?.recipe_ingredients.count ?? 0
//        }
//        else if tableView == tableViewSteps {
//            return data?.recipe_steps.count ?? 0
//        }
//        else {
//
//            if data?.recipe_comments.count > 2 {
//                return 3
//            }
//            else if data?.recipe_comments.count == 0{
//                self.delegate?.setZeroHeight(tableViewComments!)
//                return 0
//            }
//            else  {
//                //                self.delegate?.setContentHeight(tableViewComments!)
//                return (self.data?.recipe_comments.count) ??  0
//            }
//        }
//    }
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if tableView == tableViewIngredients {
//            guard let cell = tableViewIngredients?.dequeueReusableCellWithIdentifier("IngredientsTableViewCell") as? IngredientsTableViewCell else { return UITableViewCell() }
//            if let item = data?.recipe_ingredients[indexPath.row] {
//                cell.lblIngredients?.text = item
//            }
//            //            self.delegate?.setContentHeight(tableViewIngredients!)
//            return cell
//        }
//        else if tableView == tableViewComments {
//            if indexPath.row != 2{
//                guard let cell = tableViewComments?.dequeueReusableCellWithIdentifier("CommentsTableViewCell") as? CommentsTableViewCell else { return UITableViewCell() }
//
//                cell.lblComment?.text = data?.recipe_comments[indexPath.row].comment
//                cell.lblName?.text = data?.recipe_comments[indexPath.row].user_name
//                cell.lblTime?.text = data?.recipe_comments[indexPath.row].commentTime
//                if let img = data?.recipe_comments[indexPath.row].user_image_url{
//                    cell.imgOtherUserDp?.sd_setImageWithURL(NSURL(string:img),placeholderImage: UIImage(asset: .Ic_profile))
//                    cell.clipsToBounds = true
//                }
//                self.delegate?.setContentHeight(tableViewComments!)
//                return cell
//            }
//            else {
//                guard let cell = tableViewComments?.dequeueReusableCellWithIdentifier("ReadMoreTableViewCell") as? ReadMoreTableViewCell else { return UITableViewCell() }
//                cell.delegate = self
//                self.delegate?.setContentHeight(tableViewComments!)
//                return cell
//            }
//        }
//        else {
//            guard let cell = tableViewSteps?.dequeueReusableCellWithIdentifier("StepsTableViewCell") as? StepsTableViewCell else { return UITableViewCell() }
//            if let item = data?.recipe_steps[indexPath.row] {
//                cell.lblSerialNo?.text = "\(indexPath.row + 1)."
//                cell.lblSteps?.text = item
//            }
//            //            self.delegate?.setContentHeight(tableViewSteps!)
//            return cell
//        }
//    }
//
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if tableView ==  tableViewSteps {
//            return 48
//        }
//        else {
//            return UITableViewAutomaticDimension
//        }
//    }
//
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//
//}
