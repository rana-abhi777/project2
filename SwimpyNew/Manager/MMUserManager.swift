
import RMMapper
import UIKit

class MMUserManager: NSObject {
    
//    class var sharedInstance: MMUserManager {
//        struct Static {
//            static var instance: MMUserManager?
//            static var token: dispatch_once_t = 0
//        }
//        dispatch_once(&Static.token) {
//            Static.instance = MMUserManager()
//        }
//        return Static.instance!
//    }
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
//    var uuid : AnyObject? {
//        get{
//            return NSUserDefaults.standardUserDefaults().valueForKey("deviceId")!
//        }
//        set{
//            if let value = newValue {
//                return NSUserDefaults.standardUserDefaults().setValue(value, forKey: "deviceId")
//            }else{
//                NSUserDefaults.standardUserDefaults().removeObjectForKey("deviceId")
//            }
//        }
//        
//    }
}
