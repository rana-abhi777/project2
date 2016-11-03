//
//  MessageViewController.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/12/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {
    @IBOutlet weak var lblStoreName: UILabel!

    @IBOutlet weak var tableViewMessage: UITableView!
    @IBOutlet weak var btnSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnActionSend(sender: AnyObject) {
    }
    @IBAction func btnActionAttachment(sender: AnyObject) {
    }
    @IBAction func btnActionBack(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }


}
