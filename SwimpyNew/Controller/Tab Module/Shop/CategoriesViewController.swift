//
//  CategoriesViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/6/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SFFocusViewLayout

class CategoriesViewController: UIViewController , IndicatorInfoProvider {
    
    //MARK:- Outlets
    @IBOutlet weak var collectionViewCategory: UICollectionView!
    
    //MARK:- variables
    var arrCategoryData : [Category] = []    
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewCategory.delegate = self
        collectionViewCategory.dataSource = self
        
        collectionViewCategory.register(CollectionViewCell.self)
        
        collectionViewCategory.decelerationRate = UIScrollViewDecelerationRateFast
        //collectionViewCategory.backgroundColor = UIColor(red: 51/255, green: 55/255, blue: 61/255, alpha: 1)
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- functions
    func initialize() {
        
        ApiManager().getDataOfURL(withApi: API.GetCategory(APIParameters.GetCategory().formatParameters()), failure: { (err) in
            print(err)
            
            }, success: {[unowned self] (model) in
                self.arrCategoryData = (model as? [Category]) ?? []
                self.collectionViewCategory.reloadData()
                print(model)
                
            }, method: Keys.Post.rawValue, loader: true)
    }
  
    
    //MARK:- indicator info provider delegate
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: Keys.categories.rawValue)
    }
    
}

extension CategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(forIndexPath: indexPath) as CollectionViewCell
    }
    
    @objc(collectionView:willDisplayCell:forItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        (cell as? CollectionViewCell)?.category = arrCategoryData[indexPath.row]
        
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = StoryboardScene.Main.instantiateCategoryProductsViewController()
        vc.categoryName = self.arrCategoryData[indexPath.row].name ?? ""
        vc.creatorId = self.arrCategoryData[indexPath.row].createrID
        vc.categoryId = self.arrCategoryData[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
        guard
            let focusViewLayout = collectionViewCategory.collectionViewLayout as? SFFocusViewLayout
            else {
                fatalError("error casting focus layout from collection view")
        }
        
        let offset = focusViewLayout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
        
    }
    
}
