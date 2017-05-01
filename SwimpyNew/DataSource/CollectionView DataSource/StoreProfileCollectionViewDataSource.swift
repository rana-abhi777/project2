//
//  StoreProfileCollectionViewDataSource.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/3/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//
protocol NavBar {
    func setNavBarVisible(color : UIColor)
}

import UIKit

protocol StoreProfileCollectionViewTask {
    func redirectToProductDetail(productId : String)
    func hitApiAgain()
}

class StoreProfileCollectionViewDataSource: NSObject,UICollectionViewDelegate , UICollectionViewDataSource {
    //MARK:- variables
    
    var colectionView:UICollectionView?
    var datasource : StoreDetail?
    var vc : UIViewController?
    var delegate : StoreProfileCollectionViewTask?
    var pageNo : String?
    private var lastContentOffset: CGFloat = 0
    var delegateNavBar : NavBar?
    
    //MARK:- initializer
    init(colectionView: UICollectionView ,  datasource : StoreDetail, vc : UIViewController,pageNo : String?) {
        self.pageNo = pageNo
        self.colectionView = colectionView
        self.datasource = datasource
        self.vc = vc
    }
    override init() {
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource?.productData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.StoreProductCollectionViewCell.rawValue, for: indexPath) as? StoreProductCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(model: (datasource?.productData[indexPath.row])!, row: indexPath.row)
        cell.delegate = (vc as? StoreProfileViewController) ?? nil
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let response = datasource ?? StoreDetail()
        if let temp = self.pageNo , temp != "" , indexPath.row == response.productData.count - 2 {
            self.delegate?.hitApiAgain()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productId = /datasource?.productData[indexPath.row].id
        self.delegate?.redirectToProductDetail(productId: productId)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CellIdentifiers.StoreProfileCollectionReusableView.rawValue , for: indexPath) as? StoreProfileCollectionReusableView else {
            return UICollectionReusableView()
        }
        headerCell.configureCell(model: datasource ?? StoreDetail(),row : indexPath.row)
        headerCell.delegate = (vc as? StoreProfileViewController) ?? nil
        return headerCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 120 && self.lastContentOffset < scrollView.contentOffset.y   {
            if scrollView.contentOffset.y >= 60 {
                self.delegateNavBar?.setNavBarVisible(color: UIColor.white)
            }
        }
        else if self.lastContentOffset > scrollView.contentOffset.y {
            if scrollView.contentOffset.y <= 60 {
                self.delegateNavBar?.setNavBarVisible(color: UIColor.clear)
                
            }
        }
        lastContentOffset = scrollView.contentOffset.y
    }
}
extension StoreProfileCollectionViewDataSource : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:(collectionView.frame.size.width - 0)/2 , height: 275 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        
        return 0
    }
    
    
    
}


