//
//  PublicPhotoResponse.swift
//  FlickStream
//
//  Created by Jeff Ligon on 10/8/16.
//  Copyright © 2016 Jeff Ligon. All rights reserved.
//


/* good empty response
 {
 "photos": {
 "page": 1,
 "pages": 0,
 "perpage": 100,
 "total": 0,
 "photo": [] },
 "stat": "ok" }
 */

/* good single response
 { "photos": { "page": 1, "pages": 1, "perpage": 100, "total": 1,
 "photo": [
 { "id": "2990222560", "owner": "31550157@N06", "secret": "ae2fabd15c", "server": "3210", "farm": 4, "title": "The Last Great Sky Mission", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
 ] }, "stat": "ok" }
 */

/* bad username
 { "stat": "fail", "code": 1, "message": "User not found" }
 */
import UIKit

struct PublicPhotoResponse: Any {
    
    let status:Status
    let code:Int?
    let message:String?
    
    let page:Int?
    let pages:Int?
    let perpage:Int?
    var photo = [PhotoModel]()
    
    
}

extension PublicPhotoResponse {
    init?(json:[String:Any]){
        guard let page = json["page"] as? Int,
            let pages = json["pages"] as? Int,
            let perpage = json["perpage"] as? Int,
            let photoArray = json["photo"] as? [[String:Any]]
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
                self.page = nil
                self.pages = nil
                self.perpage = nil
                return
        }
        let statusText = json["stat"] as! String
        self.status = Status(rawValue: statusText)!
        self.code = nil
        self.message = nil
        self.page = page
        self.pages = pages
        self.perpage = perpage
        for photoBlob in photoArray {
            self.photo.append(PhotoModel(json: photoBlob)!)
        }
    }
}
