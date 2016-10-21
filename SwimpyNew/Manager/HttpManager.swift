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
    static func callApiWithParameters( api:API, success:@escaping HttpManagerSuccess, failure: @escaping HttpManagerFailure, method: String){
        
        let parameters = api.parameters
        let fullPath = APIConstant.baseURL.rawValue + api.route
        
        switch method {
            
        case "POST" :
//            Alamofire.request(fullPath, method: .post, parameters: parameters, encoding: JSONEncoding(rawValue: []), headers: nil).responseJSON(completionHandler: { (response) in
//                
//            })
            Alamofire.request(fullPath,method : .post, parameters: parameters, encoding: URLEncoding.default).responseJSON {
                response in switch response.result{
                case .success(let data):
                    success(data as AnyObject?)
                case .failure(let error):
                    failure(error.localizedDescription)
                }

            }

        case "GET" :
            Alamofire.request(fullPath).responseJSON { response
                in switch response.result{
                case .success(let data):
                    success(data as AnyObject?)
                case .failure(let error):
                    failure(error.localizedDescription)
                }
            }
            
        case "DELETE" : break
//            Alamofire.request(fullPath, .delete ,parameters: parameters , encoding: JSONEncoding.default, headers : nil ).responseJSON
//                {
//                    response in
//                    switch response.result
//                    {
//                    case .success(let data) :
//                        success(data)
//                    case .Failure(let error) :
//                        failure(error.localizedDescription)
//                    }
//            }
        default:
            break
        }
        
    }
    
//    static func callApiWithParameters( api:API,image : UIImage? , success:@escaping HttpManagerSuccess, failure: @escaping HttpManagerFailure, method: String){
//        let parameters = api.parameters
//        let fullPath = APIConstant.baseURL.rawValue + api.route
//        guard let ppic = image else { return }
//        let imageData = UIImageJPEGRepresentation(ppic, 0.6)
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//           {
//                multipartFormData.appendBodyPart(data: imageData, name: "image", fileName: "file.png", mimeType: "image/png")
//            }
//            for (key, value) in parameters! {
//                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(String.Encoding.utf8)!, name: key)
//            }
//            }, to: fullPath) { (encodingResult) in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        
//                        success(response.result.value as AnyObject?)
//                    }
//                case .failure(let encodingError):
//                    print(encodingError.localizedDescription)
//                    failure(encodingError.localizedDescription)
//                }
//
//        }

//        Alamofire.upload(.POST, fullPath, multipartFormData: {
//            multipartFormData in
//            if  let ppic = profilePic, let imageData = UIImageJPEGRepresentation(ppic, 0.6) {
//                multipartFormData.appendBodyPart(data: imageData, name: "image", fileName: "file.png", mimeType: "image/png")
//            }
//            for (key, value) in paramerters {
//                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
//            }
//            }, encodingCompletion: {
//                encodingResult in
//                
//                switch encodingResult {
//                case .Success(let upload, _, _):
//                    upload.responseJSON { response in
//                       
//                        success(response.result.value)
//                    }
//                case .Failure(let encodingError):
//                    print(encodingError.localizedDescription)
//                    failure(encodingError.localizedDescription)
//                }
//        })
        
//    }


    
    
    
    
}
