//
//  DataSourceTableView.swift
//  NeverMynd
//
//  Created by cbl24 on 7/4/16.
//  Copyright © 2016 Codebrew. All rights reserved.
//



import UIKit

typealias ConfigureCellBlock = (_ cell : AnyObject?, _ item : [AnyObject]?, _ indexPath : NSIndexPath) -> ()
typealias ConfigureDidSelectBlock = (NSIndexPath) -> ()
typealias ConfigureViewForHeaderBlock = (_ cell : AnyObject?, _ item : AnyObject?, _ section : Int) -> ()
typealias ConfigureViewForFooterBlock = (_ cell : AnyObject?, _ item : AnyObject?, _ section : Int) -> ()
typealias ConfigureWillDisplayBlock = (NSIndexPath) -> ()
typealias ConfigureCommitEditingStyle = (NSIndexPath) -> ()
class DataSourceTableView: NSObject , UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView?
    var sections = [AnyObject]()
    var item = [AnyObject]()
    var configureCellBlock : ConfigureCellBlock?
    var configureDidSelect : ConfigureDidSelectBlock?
    var configureViewForHeader: ConfigureViewForHeaderBlock?
    var configureViewForFooter: ConfigureViewForFooterBlock?
    var configureWillDisplay : ConfigureWillDisplayBlock?
//    var configureCommitEditingStyle : ConfigureCommitEditingStyle?
    var headerTitle = [AnyObject]()
    var footerTitle = [AnyObject]()
    var headerHight: CGFloat?
    var footerHeight: CGFloat?
    var cellName: String?
    var estimatedHeight : CGFloat?
    
    init(tableView: UITableView, cell: String, item: [AnyObject]?,headerTitle : [AnyObject] = [],estimatedHeight : CGFloat, configureCellBlock: @escaping ConfigureCellBlock, configureDidSelect: @escaping ConfigureDidSelectBlock,configureWillDisplay : @escaping ConfigureWillDisplayBlock){
        self.estimatedHeight = estimatedHeight
        self.tableView = tableView
        self.cellName = cell
        self.item = item ?? []
        if headerTitle.count > 0 {
            self.headerTitle = headerTitle
        }
        self.configureCellBlock = configureCellBlock
        self.configureDidSelect = configureDidSelect
        self.configureWillDisplay = configureWillDisplay
//        self.configureCommitEditingStyle = configureCommitEditingStyle
    }
    
    override init() {
        super.init()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if headerTitle.count == 0 {
            return 1
        }
        else {
            return headerTitle.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        guard let block = configureCellBlock else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName ?? "")
        cell?.isExclusiveTouch = true
        block(cell,item, indexPath as NSIndexPath)
        return cell ?? UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let block = configureDidSelect {
            block(indexPath)
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let block = configureViewForFooter else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellInfo")
        cell?.isExclusiveTouch = true
        block(cell,item as AnyObject?, section)
        return cell ?? UITableViewCell()
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return estimatedHeight ?? UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let block = configureWillDisplay {
            block(indexPath)
        }
    }
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
//    {
//        if let block = configureCommitEditingStyle {
//            block(indexPath)
//        }
//        
//        // self.tableMessage.deleteRowsAtIndexPaths([index!], withRowAnimation: .Fade)
//        
//    }
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let block = configureViewForHeader else { return UITableViewCell() }
//        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCellInfo")
//        cell?.exclusiveTouch = true
//        block(cell: cell,item : item, section: section)
//        return cell ?? UITableViewCell()
//        
//    }
////
//
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if headerTitle.count > 0 {
        return headerTitle[section] as? String ?? ""
            
        }
        return nil
    }
//
//    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return footerTitle[section] as? String ?? ""
//    }
//    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return footerHeight ?? 0.0
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return headerHight ?? 0.0
//    }
//    


    
    
}
