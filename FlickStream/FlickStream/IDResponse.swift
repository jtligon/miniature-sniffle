//
//  IDResponse.swift
//  FlickStream
//
//  Created by Jeff Ligon on 10/8/16.
//  Copyright © 2016 Jeff Ligon. All rights reserved.
//

import UIKit

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

/*good example
 
 Optional([
 "stat": ok,
 "user": {
    id = "81813578@N02";
    nsid = "81813578@N02";
    username =     
        {
        "_content" = jeffrogami;
        };
 }])
 */

/*bad example
 
 Optional([
    "stat": fail, 
    "code": 1, 
    "message": User not found
 ])
 */

enum Status:String{
    case fail, ok
}

struct IDResponse: Any {
 
    
    let status:Status
    let id:String?
    let nsid:String?
    let code:Int?
    let message:String?
    
}

extension IDResponse {
    init?(json:[String:Any]){
        guard let userNameJson = json["user"] as? [String:Any],
            let id = userNameJson["id"] as? String,
            let nsid = userNameJson["nsid"] as? String
            else{
                guard  let code = json["code"] as? Int,
                    let message = json["message"] as? String
                    else{
                        return nil
                }
                
                let statusText = json["stat"] as! String
                self.status = Status(rawValue: statusText)!
                self.code = code
                self.message = message
                self.id = nil
                self.nsid = nil
                return
        }
        
        let statusText = json["stat"] as! String
        self.status = Status(rawValue: statusText)!
        self.id = id
        self.nsid = nsid
        self.message = nil
        self.code = nil
    }
}

