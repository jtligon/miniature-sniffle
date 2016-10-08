//
//  ViewController.swift
//  FlickStream
//
//  Created by Jeff Ligon on 10/7/16.
//  Copyright © 2016 Jeff Ligon. All rights reserved.
//

import UIKit

class ViewController: UIViewController   {
    
    @IBOutlet var collectionView:UICollectionView?
    @IBOutlet var userSearchField:UITextField?
    var imageUrls:Array<String> =  ["", ""]

    override func viewDidLoad() {
        super.viewDidLoad()
            // set up the initial urlSession
    }

    @IBAction func clearResults(){
        print("clearing results")
        self.imageUrls = [];
        self.collectionView?.reloadData()
    }

    @IBAction func getResults(){
        print("getting pictures for listed user")
        //add the user to the url path
        
        //create the urlrequest
     
        //in the response, put each image url into the array
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.getResults();
        return true
    }
}

extension ViewController: UICollectionViewDelegate{
 
}


extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.imageUrls.count;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "flick", for: indexPath) as! CollectionViewCell
        if let cellURL = URL(string: self.imageUrls[indexPath.row]){
            cell.getImageFromUrl(url:cellURL)
        }else{
            cell.imageView?.image = nil;
        }
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
}
