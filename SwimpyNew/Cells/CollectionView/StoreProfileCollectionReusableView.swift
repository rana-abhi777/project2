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
}

class StoreProfileCollectionReusableView: UICollectionReusableView {
    
    //MARK:-  outlets
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblNumberOfFollowers: UILabel!
    @IBOutlet weak var imgStoreThumbnail: CustomImageView!
    @IBOutlet weak var imgStoreCoverPic: UIImageView!
    
    
    //MARK:-  variables
    var data : StoreDetail?
    var delegate : StoreProfileTask?
    
   
    
    
    //MARK:-  function
    func configureCell(model : StoreDetail) {
        data = model
        lblStoreName.text = model.storeName ?? ""
        lblDescription.text = model.describe ?? ""
        lblNumberOfFollowers.text = (model.totalFollow ?? "") + " followers"
        imgStoreCoverPic.sd_setImage(with: URL(string: model.coverPicURLOriginal ?? ""))
        imgStoreThumbnail.sd_setImage(with: URL(string: model.profilePicURLThumbnail ?? ""))
        
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
    }
}
