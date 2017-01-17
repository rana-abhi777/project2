//
//  MoreFromStoreTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/16/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

protocol MoreProductsDelegateFunction {
    func redirectToProductDetail(productId : String)
    func updateFollowingData(data : ProductDetail?)
    func openThisStore(sellerId : String)
}

class MoreFromStoreTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var imgStore: CustomImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var collectionViewProducts: UICollectionView!
    @IBOutlet weak var lblNumberOfFollowers: UILabel!
    @IBOutlet weak var btnFollow: CustomButton!
    
    
    //MARK:- VARIABLES
    var data : ProductDetail?
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewProducts.dataSource = collectionViewdataSource
            collectionViewProducts.delegate = collectionViewdataSource
        }
    }
    var delegate : MoreProductsDelegateFunction?
    
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
        lblNumberOfFollowers?.text = (model.numberOfFollwers ?? L10n._0.string) + L10n._Followers.string
        if (model.arrMoreFromStore?.count ?? 0) > 0 {
            configureCollectionView()
        }
        if model.hasFollowed == 1 {
            btnFollow.setTitle(L10n.following.string, for: .normal)
        }
        else {
            btnFollow.setTitle(L10n.follow.string, for: .normal)
        }
    }
    
    func configureCollectionView(){
        guard let arrProducts = data?.arrMoreFromStore else { return }
        collectionViewdataSource = CollectionViewDataSource(items: arrProducts, collectionView: collectionViewProducts, cellIdentifier: CellIdentifiers.MoreProductsCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 80, cellWidth: 80 , cellSpacing: 8, configureCellBlock: { (cell, item, indexpath) in
            let cell = cell as? MoreProductsCollectionViewCell
            
            cell?.layer.cornerRadius = 4.0
            cell?.layer.borderWidth = 2.0
            cell?.layer.borderColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor
            cell?.configureCell(model: arrProducts[indexpath.row])
            }, aRowSelectedListener: { (indexPath) in
                let id = arrProducts[indexPath.row].id ?? ""
                self.delegate?.redirectToProductDetail(productId: id)
            }, willDisplayCell: { (indexPath) in
                
                
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewProducts.reloadData()
    }
    
    //MARK:- button actions
    @IBAction func btnActionFollow(_ sender: AnyObject) {
        if data?.hasFollowed == 0 {
            let followingCount = (Int(self.data?.numberOfFollwers ?? L10n._0.string) ?? 0) + 1
            self.data?.numberOfFollwers = "\(followingCount)"
            self.data?.hasFollowed = 1
            lblNumberOfFollowers?.text = self.data?.numberOfFollwers
            self.delegate?.updateFollowingData(data: self.data)
            
            ApiManager().getDataOfURL(withApi: API.FollowStore(APIParameters.FollowStore(sellerId: data?.storeId).formatParameters()), failure: { (err) in
                print(err)
                }, success: {(model) in
                    print(model)
                    
                }, method: "PUT", loader: false)
        }
        else {
            
             let followingCount = (Int(self.data?.numberOfFollwers ?? L10n._1.string) ?? 1) - 1
            self.data?.numberOfFollwers = "\(followingCount)"
            lblNumberOfFollowers?.text = self.data?.numberOfFollwers
            self.data?.hasFollowed = 0
            self.delegate?.updateFollowingData(data : self.data)
            
            ApiManager().getDataOfURL(withApi: API.UnfollowStore(APIParameters.UnfollowStore(sellerId: data?.storeId).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                    
                }, method: "PUT", loader: false)

        }
    }
    
    @IBAction func btnActionOpenStore(_ sender: AnyObject) {
        self.delegate?.openThisStore(sellerId: data?.storeId ?? "")
    }
    
    
}
