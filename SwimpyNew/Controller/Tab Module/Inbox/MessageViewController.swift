//
//  MessageViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/12/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit
import SwiftyJSON
import EZSwiftExtensions
import Fusuma
class MessageViewController: BaseViewController {
    
    //MARK:- outlet
    
    
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var tableViewMessage: UITableView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var constBottomTextField: NSLayoutConstraint!
    @IBOutlet var lblNoChats: UILabel!
    @IBOutlet weak var viewTop: UIView!
    
    //MARK:- variables
    var arrMessages : [Message] = []
    var keyboardHeight: CGFloat?
    var imgAddress : UIImage?
    var storeId : String?
    var storeImage : String?
    var tableDataSource : ChatDataSource? {
        didSet{
            tableViewMessage.dataSource = tableDataSource
            tableViewMessage.delegate = tableDataSource
        }
    }
    var pageNo : String?
    var isLoadMore = false
    
    
    //MARK:- override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listenEvent()
        setup()
        handlePagination()
        configureTableView()
        btnSend.isExclusiveTouch = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        txtMessage.delegate = self
    }
    
    //MARK:- FUNCTION
    func resetNoMoreData(){
        self.tableViewMessage.es_resetNoMoreData()
    }
    
    func foundNoMoreData(){
        self.tableViewMessage.es_stopPullToRefresh(completion: true)
    }
    
    func handlePagination(){
        let _ = tableViewMessage.es_addPullToRefresh {
            if self.pageNo != StringNames.empty.rawValue {
                self.hitApiForChatMessages()
            }else{
                self.foundNoMoreData()
            }
        }
        tableViewMessage.refreshIdentifier = StringNames.empty.rawValue
    }
    
    func setup() {
        resetNoMoreData()
        arrMessages = []
        pageNo = L10n._0.string
        
        hitApiForChatMessages()
    }
    
    //MARK:- functions
    func scrollTableView() {
        if arrMessages.count > 0 {
            let indexPath = IndexPath(row: arrMessages.count - 1, section: 0)
            tableViewMessage.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: false)
        }
    }
    func listenEvent() {
        SocketIOManager.sharedInstance.listenCheckOutEvent { (model) in
            
            let arrChat = (model as? [Message]) ?? []
            for item in arrChat {
                self.arrMessages.append(item)
            }
            self.configureTableView()
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
        }
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
        }
        self.constBottomTextField?.constant = 20
        self.view.endEditing(true)
    }
    
    
    
    
    
    func hitApiForChatMessages() {
        //print("This is Page number : " , pageNo)
        ApiManager().getDataOfURL(withApi: API.chatListMessaging(APIParameters.chatListMessaging(sellerId: storeId,pageNo : pageNo).formatParameters()), failure: { (err) in
            print(err)
        }, success: {[unowned self] (model) in
            self.tableViewMessage.es_stopPullToRefresh(completion: true)
            guard let response = (model as? MessageData) else { return }
            self.pageNo = response.pageNo ?? nil
            var arr:[Message] = []
            for item in response.arrMessage {
                arr.append(item)
            }
            arr.append(contentsOf:self.arrMessages)
            self.arrMessages = arr
            self.isLoadMore = response.arrMessage.count > 0
            self.isLoadMore ? self.tableViewMessage.es_resetNoMoreData() : self.tableViewMessage.es_noticeNoMoreData()
            if self.arrMessages.count > 0 {
                self.pageNo == StringNames.one.rawValue ? self.configureTableView() : self.configureTableViewforTop()
            }
            self.lblNoChats.isHidden = self.arrMessages.count != 0
            }, method: Keys.Get.rawValue, loader: self.arrMessages.count == 0)
    }
    
    func configureTableView() {
        tableDataSource = ChatDataSource(tableView: tableViewMessage, datasource: arrMessages ,vc: self,storeImage : storeImage)
        tableViewMessage.reloadData()
        tableViewMessage.scrollsToTop = false
        if arrMessages.count > 0 {
            tableViewMessage.scrollToRow(at: IndexPath(row: arrMessages.count - 1 , section: 0), at: .bottom, animated: false)
        }
    }
    
    
    
    func configureTableViewforTop() {
        tableDataSource = ChatDataSource(tableView: tableViewMessage, datasource: arrMessages ,vc: self,storeImage : storeImage)
        tableViewMessage.reloadData()
        tableViewMessage.scrollsToTop = false
        if arrMessages.count > 0 {
            tableViewMessage.scrollToRow(at: IndexPath(row: 0 , section: 0), at: .bottom, animated: false)
        }
    }
    
}

//MARK:- button actions
extension MessageViewController  {
    
    @IBAction func btnActionSend(_ sender: AnyObject) {
        let msg = txtMessage.text
        guard let str = msg?.trimmed() else { return }
        txtMessage.text = StringNames.empty.rawValue
        if !(msg == StringNames.empty.rawValue || msg == Keys.writeMessage.rawValue ) && selectedImage == nil && (str.characters.count) > 0{
            let dict = [StringNames.to.rawValue : storeId ?? StringNames.empty.rawValue, StringNames.from.rawValue : MMUserManager.shared.loggedInUser?.id  ?? StringNames.empty.rawValue, Keys.message.rawValue : str ]
            SocketIOManager.sharedInstance.sendMessageEvent(message: dict)
            let msgObj = Message()
            msgObj.receiverId = storeId
            msgObj.message = str
            msgObj.imgThumbail = nil
            msgObj.imgOriginal = nil
            arrMessages.append(msgObj)
            self.lblNoChats.isHidden = self.arrMessages.count != 0
            configureTableView()
        }
        else if selectedImage != nil {
            
            ApiManager().getDataOfURL(withApi: API.uploadImage(APIParameters.uploadImage().formatParameters()), failure: { (err) in
                print(err)
            }, success: {[unowned self] (model) in
                
                guard let objUpoad = model as? UploadImage else { return }
                let dict = [StringNames.to.rawValue : self.storeId ?? StringNames.empty.rawValue, StringNames.from.rawValue : MMUserManager.shared.loggedInUser?.id  ?? StringNames.empty.rawValue, Keys.imageUrl.rawValue : [Keys.Thumbnail.rawValue : objUpoad.imgThumbail ?? StringNames.empty.rawValue , Keys.Original.rawValue : objUpoad.imgOriginal ?? StringNames.empty.rawValue] ] as [String : Any]
                print(dict)
                SocketIOManager.sharedInstance.sendMessageEvent(message: dict)
                let msgObj = Message()
                msgObj.receiverId = self.storeId
                msgObj.message = nil
                msgObj.imgThumbail = objUpoad.imgThumbail
                msgObj.imgOriginal = objUpoad.imgOriginal
                self.selectedImage = nil
                self.arrMessages.append(msgObj)
                self.lblNoChats.isHidden = self.arrMessages.count != 0
                self.configureTableView()
                
                //removing subviews after sending image
                self.txtMessage.removeSubviews()
                self.txtMessage.isUserInteractionEnabled = true
                self.txtMessage.rightViewMode = UITextFieldViewMode.never
                self.txtMessage.placeholder = Keys.reply.rawValue
                }, method: Keys.Post.rawValue, loader: true, image: selectedImage )
        }
        self.txtMessage.resignFirstResponder()
    }
    
    @IBAction func btnActionBack(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionAttachment(_ sender: AnyObject) {
        callFusumaImagePiucker(btnOutlet : UIButton())
        getTextField(textField: self.txtMessage)
    }
}

//MARK:- TextField Delegate

extension MessageViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //  var keyboardSize = NSNotification.userInfo(valueForKey(UIKeyboardFrameBeginUserInfoKey))
//        if txtMessage.text == Keys.writeMessage.rawValue {
//            txtMessage.text = nil
//            txtMessage.textColor = UIColor.black
//        }
//        UIView.animate(withDuration: 0.2, animations: {
//            self.constBottomTextField.constant = 254.0
//            self.view.layoutIfNeeded()
//            self.scrollTableView()
//        }, completion: nil)
//        return true
        
        //myCode Atirek
        
        constBottomTextField.constant = 8 + (keyboardHeight ?? 0)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        constBottomTextField.constant = 0
    }
    
    
    
}




