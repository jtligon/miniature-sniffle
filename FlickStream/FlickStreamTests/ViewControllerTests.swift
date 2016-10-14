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
    var collectionView:UICollectionView?
    var messageLabel:UILabel?
    
    override func setUp() {
        super.setUp()
        
        let layout = UICollectionViewLayout()
        self.searchField = UITextField(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 10, height: 10), collectionViewLayout:layout)
        self.messageLabel = UILabel()
        
        self.viewController = ViewController()
        
        self.viewController?.messageLabel = self.messageLabel
        self.collectionView?.dataSource = self.viewController
        self.viewController?.collectionView = self.collectionView
        self.viewController?.userSearchField = self.searchField
        
        
        self.viewController?.view.addSubview(self.collectionView!)
        self.viewController?.view.addSubview(self.searchField!)
        self.viewController?.view.addSubview(self.messageLabel!)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewController = nil
        self.searchField = nil
        self.collectionView = nil
        self.messageLabel = nil
        super.tearDown()
    }
    
    func testClearSearchField() {
        if let searchField = self.searchField{
            searchField.text = "jeffrogami"
        }
        self.viewController?.clearResults()
    }
    
    func testGoodUserNameSearch() {
        if let searchField = self.searchField{
            searchField.text = "jeffrogami"
        }
        self.viewController?.getResults()
        
    }
    
    func testBadUserName(){
        
        if let searchField = self.searchField{
            searchField.text = "jeffrogami has the best photos"
        }
        self.viewController?.getResults()
    }
    
}
