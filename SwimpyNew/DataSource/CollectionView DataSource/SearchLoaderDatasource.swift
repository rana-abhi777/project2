//
//  SearchLoaderDatasource.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/20/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit

class SearchLoaderDatasource: NSObject,UICollectionViewDelegate , UICollectionViewDataSource {
    
    //MARK:- variables
    
    var colectionView:UICollectionView?
    
    
    //MARK:- initializer
    init(colectionView: UICollectionView) {
        self.colectionView = colectionView
        
    }
    override init() {
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.SearchLoaderCollectionViewCell.rawValue, for: indexPath) as? SearchLoaderCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell()
        return cell
        
    }
    
}


extension SearchLoaderDatasource : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:(collectionView.frame.size.width - 0) , height: 80 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return 0/2
    }
    
    
    
}

