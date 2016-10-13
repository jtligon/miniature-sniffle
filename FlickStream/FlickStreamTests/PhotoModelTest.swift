//
//  PhotoModelTest.swift
//  FlickStream
//
//  Created by Jeff Ligon on 10/13/16.
//  Copyright © 2016 Jeff Ligon. All rights reserved.
//

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

import XCTest

class PhotoModelTest: XCTestCase {
    var goodJson:[String:Any]?
    var badJson:[String:Any]?
    
    override func setUp() {
        super.setUp()
        self.goodJson = [
            "id": "2990222560",
            "owner": "31550157@N06",
            "secret": "ae2fabd15c",
            "server": "3210",
            "farm": 4,
            "title": "The Last Great Sky Mission",
            "ispublic": 1,
            "isfriend": 0,
            "isfamily": 0 ]
        
        self.badJson = ["id":2990222560]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.goodJson = nil
        self.badJson = nil
        super.tearDown()
    }
    
    func testGoodJson()  {
        if let goodJson = self.goodJson {
        let goodPhotoModel = PhotoModel(json:goodJson)
        assert(goodPhotoModel != nil, "good json failed to ccreate a PhotoModel")
        }
    }
    
    func testBadReturnsNil(){
        if let badJson = self.badJson{
            let badPhotoModel = PhotoModel(json:badJson)
            assert(nil == badPhotoModel, "bad json results in a good PhotoModel!")
        }
    }
    
    //create a url and make sure it matches the expected value
    func testUrlCreation() {
        if let json = self.goodJson{
            let goodPhotoModel = PhotoModel(json:json)
            let url = goodPhotoModel?.url()
            let expectedUrl = URL(string: "https://farm4.staticflickr.com/3210/2990222560_ae2fabd15c_t.jpg")
            assert(nil != url, "url() is nil!")
            assert(url == expectedUrl, "url:\(url?.absoluteString) is different than expected!")
            
        }
    }

    
}
