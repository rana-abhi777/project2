//
//  RelatedProductsTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/16/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class RelatedProductsTableViewCell: UITableViewCell,RelatedProductsTask {

    @IBOutlet weak var collectionViewRelatedProducts: UICollectionView!
    
    
    //MARK:- VARIABLES
    var data : ProductDetail?
    var arrRelatedProducts : [RelatedProducts]?
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewRelatedProducts.dataSource = collectionViewdataSource
            collectionViewRelatedProducts.delegate = collectionViewdataSource
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK:-  function
    func configureCell(model : ProductDetail) {
//        data = model
        arrRelatedProducts = model.arrRelatedProducts
        if (model.arrRelatedProducts?.count ?? 0) > 0 {
            configureCollectionView()
        }
    }
    
    func configureCollectionView(){
        guard let arrProducts = arrRelatedProducts else { return }
        collectionViewdataSource = CollectionViewDataSource(items: arrProducts, collectionView: collectionViewRelatedProducts, cellIdentifier: CellIdentifiers.RelatedProductsCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 275, cellWidth: (UIScreen.main.bounds.width - 16)/2 , cellSpacing: 8, configureCellBlock: { (cell, item, indexpath) in
            let cell = cell as? RelatedProductsCollectionViewCell
            cell?.layer.cornerRadius = 4.0
            cell?.delegate = self
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
            cell?.configureCell(model: arrProducts[indexpath.row],row : indexpath.row)
            }, aRowSelectedListener: { (indexPath) in
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewRelatedProducts.reloadData()
    }
    func updateLikeData(model : RelatedProducts?,index : Int) {
        arrRelatedProducts?[index] = model ?? RelatedProducts()
        configureCollectionView()
        //fire one more delegate that update the main data
    }
    
}
