//
//  StoreProfileViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/7/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class StoreProfileViewController: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var collectionViewItems: UICollectionView!
    
    @IBOutlet weak var btnFollowStore: CustomButton!
    @IBOutlet weak var btnMessage: CustomButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblNumberOfFollowers: UILabel!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var imgStoreThumbnail: CustomImageView!
    @IBOutlet weak var imgStoreCoverPic: UIImageView!
    //MARK:- variables
    var sellerId = ""
    var model : StoreDetail?
    
    //MARK:- override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- functions
    func initialize() {
        hitApiForStoreDetail()
    }
    
    func hitApiForStoreDetail() {
        ApiManager().getDataOfURL(withApi: API.GetStoreDetail(APIParameters.GetStoreDetail(sellerId: sellerId).formatParameters()), failure: { (err) in
            print(err)
            }, success: {[unowned self] (model) in
                self.model = (model as? StoreDetail) ?? StoreDetail()
                self.setUI()
                print(model)
            }, method: "GET", loader: true)
    }
    
    func setUI() {
        lblStoreName.text = model?.storeName ?? ""
        lblDescription.text = model?.describe ?? ""
        lblNumberOfFollowers.text = (model?.totalFollow ?? "") + " followers"
        imgStoreCoverPic.sd_setImage(with: URL(string: model?.coverPicURLOriginal ?? ""))
        imgStoreThumbnail.sd_setImage(with: URL(string: model?.profilePicURLThumbnail ?? ""))
    }
    //MARK:- button actions
    @IBAction func btnActionFollowStore(sender: AnyObject) {
    }
    @IBAction func btnActionMessage(sender: AnyObject) {
    }
    @IBAction func btnActionSort(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateSortViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnActionFilter(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateFilterViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnActionCart(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateCartViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnActionSearch(sender: AnyObject) {
        let VC = StoryboardScene.Main.instantiateSearchViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnActionBack(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
}
