//
//  PhotoModel.swift
//  FlickStream
//
//  Created by Jeff Ligon on 10/8/16.
//  Copyright © 2016 Jeff Ligon. All rights reserved.
//

import UIKit

/*
  { 
 "id": "2990222560", 
 "owner": "31550157@N06", 
 "secret": "ae2fabd15c", 
 "server": "3210", 
 "farm": 4, 
 "title": "The Last Great Sky Mission", 
 "ispublic": 1, 
 "isfriend": 0, 
 "isfamily": 0 }
 */

struct PhotoModel: Any {
    let id:String
    let owner:String
    let secret:String
    let server:String
    let farm:Int
    let title:String
    let ispublic:Int
    let isfriend:Int
    let isfamily:Int
    
    }

extension PhotoModel{
    init?(json:[String:Any]) {
        guard let id = json["id"] as? String,
            let owner = json["owner"] as? String,
            let secret = json["secret"] as? String,
            let server = json["server"] as? String,
            let farm = json["farm"] as? Int,
            let title = json["title"] as? String,
            let ispublic = json["ispublic"] as? Int,
            let isfriend = json["isfriend"] as? Int,
            let isfamily = json["isfamily"] as? Int
            else {
                return nil
        }
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily
    }
}
