
import RMMapper
import UIKit
import SwiftyJSON

class MMUserManager: NSObject {
    
    class var shared: MMUserManager {
        struct Static {
            static let instance: MMUserManager = MMUserManager()
        }
        return Static.instance
    }
    
    override init(){
        super.init()
    }
    
    
    
    
    deinit {
    }
    var notificationData : JSON? {
        get{
            return (UserDefaults.standard.value(forKey: "SwimpyNotification") as? JSON)
        }
        set{
            if let value = newValue {
                return UserDefaults.standard.setValue(value, forKey: "SwimpyNotification")
            }else{
                UserDefaults.standard.removeObject(forKey: "SwimpyNotification")
            }
        }
        
    }
    
    var loggedInUser : User? {
        get{
            return UserDefaults.standard.rm_customObject(forKey: "SwimpyUser") as? User
        }
        set{
            
            if let value = newValue {
                UserDefaults.standard.rm_setCustomObject(value, forKey: "SwimpyUser")
            }else{
                UserDefaults.standard.removeObject(forKey: "SwimpyUser")
            }
        }
    }
    
    var deviceToken : String? {
        get{
            return UserDefaults.standard.rm_customObject(forKey: "SwimpyDeviceToken") as? String
        }
        set{
            
            if let value = newValue {
                UserDefaults.standard.rm_setCustomObject(value, forKey: "SwimpyDeviceToken")
            }else{
                UserDefaults.standard.removeObject(forKey: "SwimpyDeviceToken")
            }
        }
    }
    
    var cartCount : String? {
        get{
            return UserDefaults.standard.rm_customObject(forKey: "SwimpyCartCount") as? String
        }
        set{
            
            if let value = newValue {
                UserDefaults.standard.rm_setCustomObject(value, forKey: "SwimpyCartCount")
            }else{
                UserDefaults.standard.removeObject(forKey: "SwimpyCartCount")
            }
        }
    }
    
    
    
    
    

}
