//
//  AppDelegate.swift
//  Swimpy
//
//  Created by Aseem 10 on 10/5/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//
import UIKit
import FBSDKShareKit
import FBSDKCoreKit
import FBSDKLoginKit
import IQKeyboardManager
import XLPagerTabStrip
import UserNotifications
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var flagg: Bool = false
    
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.applicationIconBadgeNumber = 0
        UIApplication.shared.statusBarStyle = .lightContent
//        UITabBar.appearance().backgroundColor = UIColor.white
//        
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for:.selected)
        IQKeyboardManager.shared().isEnabled = true
        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert])
        { (granted, error) in
            if granted == true{
                NSLog("Granted")
                UIApplication.shared.registerForRemoteNotifications()
            }
            if let error = error {
                print(error.localizedDescription)
               // print("Error: \(error.description)")
            }
        }
        
        registerForRemoteNotification()
        
    
         //guard let pushNotificationUserInfo = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? [AnyHashable : Any] else {return true }
      
     //   guard let dictPush = (launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? [NSObject : AnyObject]) else { return true }
       
        //  print(pushNotification)
     //   let data = JSON(pushNotificationUserInfo)
     //   MMUserManager.sharedInstance.notificationData = data
        
     //   handlePushNavigation(userInfo: data)
        
        return true
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation]) {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        } else {
            return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation:  options[UIApplicationOpenURLOptionsKey.annotation])
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        SocketIOManager.sharedInstance.establishConnection()
         UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    //MARK:- push notification delegate
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let chars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var token = ""
        
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", arguments: [chars[i]])
        }
        
        print("Device Token = ", token)
        MMUserManager.shared.deviceToken = token
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,  willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (_ options:   UNNotificationPresentationOptions) -> Void) {
        print("Handle push from foreground")
        print("\(notification.request.content.userInfo)")
        let data =  JSON(notification.request.content.userInfo)
        
        if data.isEmpty {
            return
        }else {
            handlePush(userInfo : data)
        }
        print(data)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Handle push from background or closed")
        
        print("\(response.notification.request.content.userInfo)")
        let data =  JSON(response.notification.request.content.userInfo)
        
        if data.isEmpty {
            return
        }else {
            handlePush(userInfo : data)
        }
        print(data)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
    }
    
}
extension AppDelegate {
    
    
    func registerForRemoteNotification() {
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }

    
    func handlePush(userInfo : JSON){
        
        let dictio = userInfo["aps"].dictionaryValue
        
        let message = dictio["alert"]?.stringValue ?? ""
        
        
        
        if UIApplication.shared.applicationState == .active {
            
            let notification = UILocalNotification()
            notification.fireDate = NSDate(timeIntervalSinceNow: 5) as Date
            notification.alertBody = message
            notification.timeZone = NSTimeZone.default
            notification.alertAction = "be awesome!"
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(notification)
            HDNotificationView.show(with: UIImage(contentsOfFile: "" ), title: "Swimpy", message: message, isAutoHide: true) { [weak self] in
                HDNotificationView.hide()
                self?.handlePushNavigation(userInfo: userInfo)
            }
            
        }else {
            handlePushNavigation(userInfo: userInfo )
        }
    }
    
    
    func handlePushNavigation(userInfo :  JSON){
        
        let id =  userInfo["id"].stringValue
        if id == "" {
            return
        }
        
        
        
        let storybard = UIStoryboard(name: "Main", bundle: nil)
        /*guard  let VC = storybard.instantiateViewController(withIdentifier: Constant.Identifier.OrderDetailVC.rawValue) as? OrderDetailVC else{ return }
        
        VC.checkNoti = 1
        VC.orderID = id
        
        
        let navController = self.window?.rootViewController as? UINavigationController
        navController?.pushViewController(VC, animated: true)*/
    }

}
