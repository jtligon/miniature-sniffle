//
//  PublicPhotoResponse.swift
//  FlickStream
//
//  Created by Jeff Ligon on 10/8/16.
//  Copyright © 2016 Jeff Ligon. All rights reserved.
//


/* good empty response
 { "photos": { "page": 1, "pages": 0, "perpage": 100, "total": 0,
 "photo": [
 
 ] }, "stat": "ok" }
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

class PublicPhotoResponse: Any {

}
