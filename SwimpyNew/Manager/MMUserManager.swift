
import RMMapper
import UIKit

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
}
