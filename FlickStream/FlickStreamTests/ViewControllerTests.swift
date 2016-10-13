//
//  ViewControllerTests.swift
//  FlickStream
//
//  Created by Jeff Ligon on 10/13/16.
//  Copyright © 2016 Jeff Ligon. All rights reserved.
//

import XCTest

class ViewControllerTests: XCTestCase {
    var viewController:ViewController?
    var searchField:UITextField?
    
    override func setUp() {
        super.setUp()
        self.viewController = ViewController()
        self.searchField = self.viewController?.userSearchField //may be nil if not created on storyboard
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewController = nil
        self.searchField = nil
        super.tearDown()
    }
    
    func testClearSearchField() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
