//
//  StoreProfileCollectionReusableView.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/3/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
protocol StoreProfileTask {
    func updateFollowData(model: StoreDetail?, index: Int)
    func redirectToMessageScreen()
}

class StoreProfileCollectionReusableView: UICollectionReusableView {
    
    //MARK:-  outlets
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblNumberOfFollowers: UILabel!
    @IBOutlet weak var imgStoreThumbnail: CustomImageView!
    @IBOutlet weak var imgStoreCoverPic: UIImageView!
    @IBOutlet weak var btnFollowStore: CustomButton!
    
    @IBOutlet weak var lblStoreNameback: UILabel!
    //MARK:-  variables
    var data : StoreDetail?
    var delegate : StoreProfileTask?
    var  index : Int = 0
    var allData: AllSellerForUser?
    
    //MARK:-  function
    func configureCell(model : StoreDetail,row : Int) {
        data = model
        index = row
        lblStoreName.text = /model.storeName
        lblDescription.text = /model.describe
        lblNumberOfFollowers.text = (/model.totalFollow) + L10n._Followers.string
        //imgStoreCoverPic.sd_setImage(with: URL(string: /model.coverPicURLOriginal ))
        if /model.coverPicURLOriginal == "" {
            //lblStoreName.text = /model.storeName
            //imgStoreCoverPic.backgroundColor = .lightGray
            imgStoreCoverPic.image = #imageLiteral(resourceName: "ic_img")
            imgStoreCoverPic.alpha = 0.7
        }
        else{
            lblStoreName.isHidden = true
            imgStoreCoverPic.sd_setImage(with: URL(string: /model.coverPicURLOriginal ))
        }
        imgStoreThumbnail.sd_setImage(with: URL(string: /model.profilePicURLThumbnail))
        if model.followStatus == 1 {
            btnFollowStore.setTitle(L10n.following.string, for: .normal)
            btnFollowStore.setTitleColor(UIColor.btnColor()
                , for: .normal)
            btnFollowStore?.borderColor = UIColor.btnColor()
        } else {
            btnFollowStore.setTitle(L10n.followStore.string, for: .normal)
            btnFollowStore?.borderColor =  UIColor.black
            btnFollowStore.setTitleColor(UIColor.black
                , for: .normal)
        }
    }
    
    func hitApiForGetAllSellerForUser(pageNo: String , completion: @escaping(Any) -> ()){
        ApiManager().getDataOfURL(withApi: API.GetAllSellerForUser(APIParameters.GetAllSellerForUser(pageNo: pageNo).formatParameters()), failure: { (err) in
            print(err)
        }, success: { (model) in
            let response = model as! AllSellerForUser ?? AllSellerForUser()
            completion(model)
        }, method: Keys.Get.rawValue, loader: false)
    }
    
    //MARK:-  button actions
    @IBAction func btnActionMessage(_ sender: AnyObject) {
        self.delegate?.redirectToMessageScreen()
    }
    
    @IBAction func btnActionFollowStore(_ sender: AnyObject) {
        if UserFunctions.checkInternet() {
            btnFollowStore.setTitle(data?.followStatus == 0 ? L10n.follow.string : L10n.following.string , for: .normal)
            let followingCount = (/self.data?.followStatus).advanced(by : /data?.followStatus == 0 ? 1 : -2)
            self.data?.totalFollow = String((self.data?.totalFollow?.toInt())! + followingCount)
            self.data?.followStatus = /data?.followStatus == 0 ? 1 : 0
            lblNumberOfFollowers?.text = self.data?.totalFollow
            self.delegate?.updateFollowData(model: self.data, index: self.index)
            btnFollowStore.setTitleColor(/data?.followStatus == 0 ? UIColor.btnColor() : UIColor.black, for: .normal)
            btnFollowStore?.borderColor = /data?.followStatus == 0 ? UIColor.btnColor() : UIColor.black
            ApiManager().getDataOfURL(withApi: API.FollowStore(APIParameters.FollowStore(sellerId: data?.id).formatParameters(),type: /data?.followStatus == 0), failure: { (err) in
                print(err)
                }, success: {(model) in
                }, method: Keys.Put.rawValue, loader: false)
        }else {
            UserFunctions.showAlert(message: L10n.yourInternetConnectionSeemsToBeOffline.string)
        }
    }
}
