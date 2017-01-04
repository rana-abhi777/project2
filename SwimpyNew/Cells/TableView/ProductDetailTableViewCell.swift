//
//  ProductDetailTableViewCell.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 12/13/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import DropDown
import UIKit

protocol ProductDetailTask {
    func updateLikeData(model : ProductDetail?)
    func redirectToCart(model : ProductDetail?)
    func openStore(sellerId : String)
}

class ProductDetailTableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    
    @IBOutlet weak var imgStoreLogo: CustomImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblStoreFollowers: UILabel!
    @IBOutlet weak var lblSelectedColor: UILabel!
    @IBOutlet weak var lblNumberOfShare: UILabel!
    @IBOutlet weak var lblSelectedSize: UILabel!
    @IBOutlet weak var imgShare: UIImageView!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var lblNumberOfLikes: UILabel!
    @IBOutlet weak var btnSelectSize: UIButton!
    @IBOutlet weak var btnSelectColor: UIButton!
    @IBOutlet weak var collectionViewLIkeUser: UICollectionView!
    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var constCollectionViewLikeUserWidth: NSLayoutConstraint!
    
    //MARK:- Variables
    let selectColorDropDown = DropDown()
    let selectSizeDropDown = DropDown()
    var data : ProductDetail?
    var collectionViewdataSource : CollectionViewDataSource?{
        didSet{
            collectionViewLIkeUser.dataSource = collectionViewdataSource
            collectionViewLIkeUser.delegate = collectionViewdataSource
        }
    }
    var delegate : ProductDetailTask?
    lazy var dropDowns: [DropDown] = {
        return [
            self.selectColorDropDown,
            self.selectSizeDropDown
        ]
    }()
    
    //MARK:-  Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK:-  function
    func configureCell(model : ProductDetail) {
        data = model
        selectColorDropDown.anchorView = btnSelectColor
        selectColorDropDown.bottomOffset = CGPoint(x: 0, y: 40)
        selectColorDropDown.dataSource = model.color ?? []
        
        selectSizeDropDown.anchorView = btnSelectColor
        selectSizeDropDown.bottomOffset = CGPoint(x: 0, y: 80)
        selectSizeDropDown.dataSource = model.variations ?? []
        
        
        imgStoreLogo.sd_setImage(with: URL(string: model.storeImgThumbnail ?? ""))
        lblStoreName.text = model.storeName ?? ""
        lblStoreFollowers.text = (model.numberOfFollwers ?? "0") + " followers"
        
        lblProductName.text = model.productName ?? ""
        lblDescription.text = model.describe
        lblPrice.text = "$" + "\(model.base_price_unit ?? 0.0)"
        lblNumberOfLikes.text = model.totalLikes ?? "0"
        lblNumberOfShare.text = "\(model.share ?? 0)"
        lblSelectedColor.text = (model.color?.count ?? 0) > 0 ?  model.color?[0] : ""
        lblSelectedSize.text = (model.variations?.count ?? 0) > 0 ? model.variations?[0] : ""
        model.colorSelected = lblSelectedColor.text
        model.sizeSelected = lblSelectedSize.text
        if model.likesStatus == 0 {
            imgLike.image = UIImage(asset: .icLike)
        }
        else {
            imgLike.image = UIImage(asset: .icLikeOn)
        }
        imgShare.image = UIImage(asset: .icShare)
        if (model.arrLikeUser?.count ?? 0) > 0 {
            configureCollectionView()
        }else {
            lblLikes.isHidden = true
            imgHeart.isHidden = true
        }
    }
    
    
    func configureCollectionView(){
        let temp = data?.arrLikeUser ?? []
        var arrLike : [LikeUser] = []
        
        for (index,item) in temp.enumerated() {
            if index < 5 {
                arrLike.append(item)
                constCollectionViewLikeUserWidth.constant = CGFloat(arrLike.count * 26)
                self.layoutIfNeeded()
            }else {
                break
            }
        }
        switch temp.count {
        case _ where temp.count > 5:
            lblLikes.isHidden = false
            lblLikes.text = "+ " + "\(temp.count - 5) " + "Others"
            break
        case _ where temp.count == 5 :
            constCollectionViewLikeUserWidth.constant = 120.0
            self.layoutIfNeeded()
            break
        case _ where temp.count == 1 :
            constCollectionViewLikeUserWidth.constant = 40.0
            self.layoutIfNeeded()
            break
        case _ where temp.count < 5 :
            constCollectionViewLikeUserWidth.constant = CGFloat(arrLike.count * 26)
            self.layoutIfNeeded()
            break
            
        default:
            break
        }
        
        if arrLike.count <= 5 {
            lblLikes.isHidden = false
            if arrLike.count == 1 {
                lblLikes.text =  "\(arrLike.count) " + "user"
            }
            else {
                lblLikes.text =  "\(arrLike.count) " + "users"
            }
        }
        
        collectionViewdataSource = CollectionViewDataSource(items: arrLike, collectionView: collectionViewLIkeUser, cellIdentifier: CellIdentifiers.ProductLikeUserCollectionViewCell.rawValue, headerIdentifier: "", cellHeight: 35, cellWidth: 20 , cellSpacing: 0, configureCellBlock: { (cell, item, indexpath) in
            let cell = cell as? ProductLikeUserCollectionViewCell
            cell?.configureCell(model: arrLike[indexpath.row])
            }, aRowSelectedListener: { (indexPath) in
            }, willDisplayCell: { (indexPath) in
                
            }, scrollViewListener: { (UIScrollView) in
        })
        collectionViewLIkeUser.reloadData()
    }
    
    
    //MARK:- button actions
    
    @IBAction func btnActionOpenStore(_ sender: AnyObject) {
        self.delegate?.openStore(sellerId: data?.storeId ?? "")
    }
    @IBAction func btnActionSelectSize(_ sender: AnyObject) {
        selectSizeDropDown.show()
        selectSizeDropDown.selectionAction = { [unowned self] (index, item) in
            self.lblSelectedSize.text = self.data?.variations?[index]
            self.data?.sizeSelected = self.lblSelectedSize.text
        }
    }
    
    @IBAction func btnActionSelectColor(_ sender: AnyObject) {
        selectColorDropDown.show()
        selectColorDropDown.selectionAction = { [unowned self] (index, item) in
            self.lblSelectedColor.text = self.data?.color?[index]
            self.data?.colorSelected = self.lblSelectedColor.text
        }
    }
    
    @IBAction func btnActionLike(_ sender: AnyObject) {
        if data?.likesStatus == 0 {
            self.imgLike.image = UIImage(asset : .icLikeOn)
            let likeCount = (Int(self.data?.totalLikes ?? "0") ?? 0) + 1
            self.data?.totalLikes = "\(likeCount)"
            self.data?.likesStatus = 1
            lblNumberOfLikes.text = self.data?.totalLikes
            self.delegate?.updateLikeData(model: self.data)
            ApiManager().getDataOfURL(withApi: API.LikeProduct(APIParameters.LikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in

                }, method: "POST", loader: false)
        }
        else {
            self.imgLike.image = UIImage(asset : .icLike)
            
            let likeCount = (Int(self.data?.totalLikes ?? "1") ?? 1) - 1
            self.data?.totalLikes = "\(likeCount)"
            lblNumberOfLikes.text = self.data?.totalLikes ?? "0"
            
            self.data?.likesStatus = 0
            
            self.delegate?.updateLikeData(model: self.data)
            ApiManager().getDataOfURL(withApi: API.DislikeProduct(APIParameters.DislikeProduct(productId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: {(model) in
                    print(model)
                }, method: "POST", loader: false)
        }
    }
    
    @IBAction func btnActionShare(_ sender: AnyObject) {
    }
    @IBAction func btnActionAddToCart(_ sender: AnyObject) {
        self.delegate?.redirectToCart(model: self.data)
    }
    @IBAction func btnActionBuyNow(_ sender: AnyObject) {
    }
}
