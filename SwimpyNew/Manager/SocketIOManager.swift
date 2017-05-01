//
//  SocketIOManager.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 10/19/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import Foundation
import SwiftyJSON


enum SocketEvent : String {
    case CheckOut = "checkOut"
}


class SocketIOManager: NSObject {
    
    
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: APIConstant.baseURL.rawValue)!)
    
    
    override init() {
        super.init()
    }
    
    deinit {
    }
    
    struct Static
    {
        static var instance: SocketIOManager?
    }
    
    class var sharedInstance: SocketIOManager
    {
        if Static.instance == nil
        {
            Static.instance = SocketIOManager()
        }
        
        return Static.instance!
    }
    
    func dispose()
    {
        SocketIOManager.Static.instance = nil
        print("Disposed Singleton instance")
    }
    
    func establishConnection() {
        if socket.status == SocketIOClientStatus.connected{}else{
            socket.connect()
            print("connection establish")
        }
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func listenCheckOutEvent(response : @escaping (AnyObject?) -> ()) {
        let str = "message_" + /MMUserManager.shared.loggedInUser?.id
        socket.on(str){
            (dataArray, socketAck) in
            let json = JSON(dataArray)
            print(json)
            let arr = Message.changeSocketDictToArr(jsoon1: json)
            print(arr.count)
            response(arr as AnyObject?)
        }
    }
    
    
    func sendMessageEvent(message : [String: Any]) {
        print(message)
        socket.emit("sendMessage",message)
    }
    
    func serverlistenEvent(message : String , response : @escaping (AnyObject?) -> ()) {
        socket.emit("connection", message)
    }
  
}
