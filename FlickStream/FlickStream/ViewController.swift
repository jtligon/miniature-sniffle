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
    @IBOutlet var userSearchField:UITextField!
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    
    var imageUrls:Array<String> =  ["https://upload.wikimedia.org/wikipedia/commons/e/e4/Stourhead_garden.jpg", ""]
    
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
        if !userSearchField.text!.isEmpty {
            
            let expectedCharSet = CharacterSet.urlQueryAllowed
            let username = userSearchField.text!.addingPercentEncoding(withAllowedCharacters:  expectedCharSet)!
            
//            print("getting pictures for listed user:\(username)")
            
            let urlString = "https://api.flickr.com/services/rest/?method=flickr.people.findByUsername" + "&api_key=\(Secrets.apiKey())&username=\(username)&format=json&nojsoncallback=1"
            
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            
            dataTask = defaultSession.dataTask(with: request, completionHandler: {
                (data, response, error) in
                
                if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] {
                    if let user = json?["user"] as? [String:Any]{
                        if let userid = user["id"] as? String{
                            self.getPublicPhotos(userid: userid)
                        }
                    }
                } else {
                    print(error?.localizedDescription)
                }
            })
            
            dataTask?.resume()
            
        }
    }
    
    func getPublicPhotos(userid:String){
        
       let urlString =  "https://api.flickr.com/services/rest/?method=flickr.people.getPublicPhotos" + "&api_key=\(Secrets.apiKey())&user_id=\(userid)&format=json&nojsoncallback=1"
        
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
        cell.backgroundColor = UIColor.cyan
        
        return cell
    }
    
}
