//
//  HttpManager.swift
//  SwimpyNew
//
//  Created by Aseem 10 on 10/19/16.
//  Copyright © 2016 Aseem 10. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias HttpManagerSuccess = (AnyObject?) -> ()
typealias HttpManagerFailure = (String) -> ()


class HttpManager {
    
    static func getHeader() -> [String : String]? {
        guard let _ = MMUserManager.shared.loggedInUser?.accessToken  else {
            return nil
        }
        let header  = [ "Authorization" : "bearer " + (MMUserManager.shared.loggedInUser?.accessToken ?? ""), "Content-Type" : "application/x-www-form-urlencoded"]
        return header
    }
    
    
    static func callApiWithParameters( api:API, success:@escaping HttpManagerSuccess, failure: @escaping HttpManagerFailure, method: String){
        
        let parameters = api.parameters
        let fullPath = APIConstant.baseURL.rawValue + api.route
        
        switch method {
            
        case "POST" :
            Alamofire.request(fullPath, method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: getHeader()  ).responseJSON { response in // 1
                switch response.result {
                    
                case .success(let data):
                    success(data as AnyObject?)
                case .failure(let error):
                    failure(error.localizedDescription)
                }
            }
            
        case "GET" :
            Alamofire.request(fullPath, method: .get, parameters: parameters, encoding: URLEncoding.default ,headers: getHeader()).responseJSON { response in
                switch response.result {
                case .success(let data):
                    success(data as AnyObject?)
                case .failure(let error):
                    failure(error.localizedDescription)
                    
                }
            }
            
        default:
            break
        }
    }
    
    static func callApiWithParameters( api:API,image : UIImage? , success:@escaping HttpManagerSuccess, failure: @escaping HttpManagerFailure, method: String){
        var imageData : Data?
        var flagImage = true
        guard let parameters = api.parameters else { return failure("Empty Parameters") }
        let fullPath = APIConstant.baseURL.rawValue + api.route
        if let ppic = image {
            imageData = UIImageJPEGRepresentation(ppic,0.6)
        }
        else {
            flagImage = false
        }
        
        Alamofire.upload(multipartFormData: {multipartFormData in
            if flagImage {
                multipartFormData.append(imageData!, withName : "profilePic", fileName: "file.png", mimeType: "image/png")
            }
            for (key, value) in parameters {
                multipartFormData.append(value.data(using : String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: fullPath) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    success(response.result.value as AnyObject?)
                }
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
                failure(encodingError.localizedDescription)
            }
            
        }
    }
    
}










