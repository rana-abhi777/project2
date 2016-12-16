//
//  MoreFromStoreTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/16/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class MoreFromStoreTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var imgStore: CustomImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var collectionViewProducts: UICollectionView!
    @IBOutlet weak var lblNumberOfFollowers: UILabel!
    
    
    
    //MARK:- VARIABLES
    var data : ProductDetail?
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewProducts.dataSource = collectionViewdataSource
            collectionViewProducts.delegate = collectionViewdataSource
        }
    }
    
    
    //MARK:- override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:-  function
    func configureCell(model : ProductDetail) {
        data = model
        imgStore?.sd_setImage(with: URL(string: model.storeImgThumbnail ?? ""))
        lblStoreName?.text = model.storeName ?? ""
        lblNumberOfFollowers?.text = (model.numberOfFollwers ?? "0") + " followers"
        if (model.arrMoreFromStore?.count ?? 0) > 0 {
            configureCollectionView()
        }
    }
    
    func configureCollectionView(){
        guard let arrProducts = data?.arrMoreFromStore else { return }
        collectionViewdataSource = CollectionViewDataSource(items: arrProducts, collectionView: collectionViewProducts, cellIdentifier: CellIdentifiers.MoreProductsCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 80, cellWidth: 80 , cellSpacing: 8, configureCellBlock: { (cell, item, indexpath) in
            let cell = cell as? MoreProductsCollectionViewCell
            cell?.layer.borderWidth = 1.0
            cell?.layer.borderColor = UIColor.white.cgColor
            cell?.configureCell(model: arrProducts[indexpath.row])
            }, aRowSelectedListener: { (indexPath) in
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewProducts.reloadData()
    }
    
    //MARK:- button actions
    @IBAction func btnActionFollow(_ sender: AnyObject) {
    }
    
}
