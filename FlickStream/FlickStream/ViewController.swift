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
    
    let expectedCharSet = CharacterSet.urlQueryAllowed
    
    var imageUrls = [URL?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set up the initial urlSession
    }
    
    @IBAction func clearResults(){
        
        print("clearing results")
        self.imageUrls = [];
        self.userSearchField.text = ""
        self.collectionView?.reloadData()
    }
    
    @IBAction func getResults(){
        if !userSearchField.text!.isEmpty {
            
            let username = userSearchField.text!.addingPercentEncoding(withAllowedCharacters:  expectedCharSet)!
            
            let urlString = "https://api.flickr.com/services/rest/?method=flickr.people.findByUsername" + "&api_key=\(Secrets.apiKey())&username=\(username)&format=json&nojsoncallback=1"
            
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            
            dataTask = defaultSession.dataTask(with: request, completionHandler: {
                (data, response, error) in
                
                if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] {
                    if let userResponse = IDResponse(json: json!){
                        if userResponse.status == .ok{
                            print("good response:\(userResponse)")
                            self.getPublicPhotos(userid: userResponse.id!)
                        }else{
                            print("got error code:\(userResponse.code) - Message:\(userResponse.message)")
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
        let url = URL(string:urlString)!
        let request = URLRequest(url: url)
        dataTask = defaultSession.dataTask(with: request, completionHandler:{
        (data, response, error) in
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]{
                if let publicResponse = PublicPhotoResponse(json:json!){
                    if publicResponse.status == .ok{
                        // create the image urls from the response,
                        self.imageUrls = publicResponse.photo.map{    $0.url() }
                        //then reload the collectionView on the main thread
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }

                    }
                }
            }else{
                print(error?.localizedDescription)
            }
        })
        dataTask?.resume()
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
        if let cellURL = self.imageUrls[indexPath.row]{
            cell.getImageFromUrl(url:cellURL)
        }else{
            cell.imageView?.image = nil;
        }
        
        return cell
    }
    
}
