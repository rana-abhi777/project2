//
//  StoreProfileCollectionReusableView.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 1/3/17.
//  Copyright © 2017 Aseem 10. All rights reserved.
//

import UIKit
protocol StoreProfileTask {
    func sortPressed()
    func filterPressed()
    func openCart()
    func openSearch()
    func goBack()
    func updateFollowData(model: StoreDetail?, index: Int)
}

class StoreProfileCollectionReusableView: UICollectionReusableView {
    
    //MARK:-  outlets
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblNumberOfFollowers: UILabel!
    @IBOutlet weak var imgStoreThumbnail: CustomImageView!
    @IBOutlet weak var imgStoreCoverPic: UIImageView!
    @IBOutlet weak var btnFollowStore: CustomButton!
    
    //MARK:-  variables
    var data : StoreDetail?
    var delegate : StoreProfileTask?
    var  index : Int = 0
    
    //MARK:-  function
    func configureCell(model : StoreDetail,row : Int) {
        data = model
        index = row
        lblStoreName.text = model.storeName ?? ""
        lblDescription.text = model.describe ?? ""
        lblNumberOfFollowers.text = (model.totalFollow ?? "") + " followers"
        imgStoreCoverPic.sd_setImage(with: URL(string: model.coverPicURLOriginal ?? ""))
        imgStoreThumbnail.sd_setImage(with: URL(string: model.profilePicURLThumbnail ?? ""))
        if model.followStatus == "1" {
            btnFollowStore.setTitle("Following", for: .normal)
            btnFollowStore.setTitleColor(UIColor(red: 1, green: 152/255, blue: 0, alpha: 1)
                , for: .normal)
            btnFollowStore?.borderColor = UIColor(red: 1, green: 152/255, blue: 0, alpha: 1)
        } else {
            btnFollowStore.setTitle("Follow store", for: .normal)
            btnFollowStore?.borderColor =  UIColor.black
            btnFollowStore.setTitleColor(UIColor.black
                , for: .normal)
        }
    }
    
    
    //MARK:-  button actions
    @IBAction func btnActionCart(_ sender: AnyObject) {
        self.delegate?.openCart()
    }
    
    @IBAction func btnActionSearch(_ sender: AnyObject) {
        self.delegate?.openSearch()
    }
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        self.delegate?.goBack()
    }
    
    @IBAction func btnActionSort(_ sender: AnyObject) {
        self.delegate?.sortPressed()
    }
    
    @IBAction func btnActionFilter(_ sender: AnyObject) {
        self.delegate?.filterPressed()
    }
    
    @IBAction func btnActionMessage(_ sender: AnyObject) {
    }
    
    @IBAction func btnActionFollowStore(_ sender: AnyObject) {
        if data?.followStatus == "0" {
            self.data?.followStatus = "1"
            btnFollowStore?.setTitle("Following", for: .normal)
            btnFollowStore.setTitleColor(UIColor(red: 1, green: 152/255, blue: 0, alpha: 1)
                , for: .normal)
            btnFollowStore?.borderColor = UIColor(red: 1, green: 152/255, blue: 0, alpha: 1)
            let totalFollowers = "\((Int(data?.totalFollow ?? "0") ?? 0) + 1)"
            lblNumberOfFollowers.text = totalFollowers + " followers"
            data?.totalFollow = totalFollowers
            self.delegate?.updateFollowData(model: self.data, index: self.index)
            
            ApiManager().getDataOfURL(withApi: API.FollowStore(APIParameters.FollowStore(sellerId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                    
                }, method: "PUT", loader: false)
        }
        else {
            btnFollowStore?.setTitle("Follow store", for: .normal)
            btnFollowStore?.borderColor =  UIColor.black
            btnFollowStore.setTitleColor(UIColor.black
                , for: .normal)
            self.data?.followStatus = "0"
            let totalFollowers = "\((Int(data?.totalFollow ?? "1") ?? 1) - 1)"
            lblNumberOfFollowers.text = totalFollowers + " followers"
            data?.totalFollow = totalFollowers
            
            self.delegate?.updateFollowData(model: self.data, index: self.index)
            
            ApiManager().getDataOfURL(withApi: API.UnfollowStore(APIParameters.UnfollowStore(sellerId: data?.id).formatParameters()), failure: { (err) in
                print(err)
                }, success: { (model) in
                    print(model)
                    
                }, method: "PUT", loader: false)
        }
    }
}
