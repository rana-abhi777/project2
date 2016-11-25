//
//  CollectionViewDataSource.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 11/24/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

typealias ScrollViewScrolled = (UIScrollView) -> ()

class CollectionViewDataSource: NSObject {
    
    var items : Array<AnyObject>?
    var cellIdentifier : String?
    var headerIdentifier : String?
    var collectionView  : UICollectionView?
    var cellHeight : CGFloat = 0.0
    var cellWidth : CGFloat = 0.0
    var cellSpacing : CGFloat = 0.0
    var scrollViewListener : ScrollViewScrolled?
    var configureCellBlock : ListCellConfigureBlock?
    var aRowSelectedListener : DidSelectedRow?
    
    init (items : Array<AnyObject>?  , collectionView : UICollectionView? , cellIdentifier : String? , headerIdentifier : String? , cellHeight : CGFloat , cellWidth : CGFloat  ,cellSpacing : CGFloat , configureCellBlock : ListCellConfigureBlock?  , aRowSelectedListener : DidSelectedRow? , scrollViewListener : ScrollViewScrolled?
        )  {
        
        self.collectionView = collectionView
        
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.headerIdentifier = headerIdentifier
        self.cellWidth = cellWidth
        self.cellSpacing = cellSpacing
        self.cellHeight = cellHeight
        self.configureCellBlock = configureCellBlock
        self.aRowSelectedListener = aRowSelectedListener
        self.scrollViewListener = scrollViewListener
        
    }
    
    override init() {
        super.init()
    }
    
}
extension CollectionViewDataSource : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let identifier = cellIdentifier else{
            fatalError("Cell identifier not provided")
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier ,
                                                      for: indexPath as IndexPath) as UICollectionViewCell
        if let block = self.configureCellBlock , let item: AnyObject = self.items?[indexPath.row]{
            block(cell , item , indexPath)
        }
        return cell
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let block = self.aRowSelectedListener{
            block(indexPath as IndexPath)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let block = scrollViewListener {
            block(scrollView)
        }
    }
    
}


extension CollectionViewDataSource : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return cellSpacing/2
    }
    
    
    
}

