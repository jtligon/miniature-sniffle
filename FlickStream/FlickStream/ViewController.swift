//
//  ViewController.swift
//  FlickStream
//
//  Created by Jeff Ligon on 10/7/16.
//  Copyright © 2016 Jeff Ligon. All rights reserved.
//

import UIKit

class ViewController: UIViewController   {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var collectionView:UICollectionView?
    @IBOutlet var userSearchField:UITextField!
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    
    let expectedCharSet = CharacterSet.urlQueryAllowed
    
    var imageUrls = [URL?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = ""
        messageLabel.layer.cornerRadius = 5.0
        self.collectionView?.layer.cornerRadius = 10
        
        //give the search field focus when we land on this viewController.
        userSearchField.becomeFirstResponder()
    }
    
    @IBAction func clearResults(){
        
        print("clearing results")
        self.imageUrls = [];
        self.userSearchField.text = ""
        self.collectionView?.reloadData()
    }
    
    @IBAction func getResults(){
        //if user search is empty, clear the results, otherwise
        if userSearchField.text!.isEmpty {
           self.clearResults()
        }else{
            //escape the characters needed
            let username = userSearchField.text!.addingPercentEncoding(withAllowedCharacters:  expectedCharSet)!
            
            // TODO: better constructor for the url components. quick and dirty
            let urlString = "https://api.flickr.com/services/rest/?method=flickr.people.findByUsername" + "&api_key=\(Secrets.apiKey())&username=\(username)&format=json&nojsoncallback=1"
            let url = URL(string: urlString)!
            let request = URLRequest(url: url)
            
            //if one exists already, cancel it and release it before we create a new one.
            if dataTask != nil{
                dataTask?.cancel()
                dataTask = nil
            }
            
            //create the datatask
            dataTask = defaultSession.dataTask(with: request, completionHandler: {
                (data, response, error) in
                
                if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] {
                    if let userResponse = IDResponse(json: json!){
                        if userResponse.status == .ok{
                            print("good response:\(userResponse)")
                            //move to a new func for next flickr call
                            self.getPublicPhotos(userid: userResponse.id!)
                        }else{
                            //response errors here
                            DispatchQueue.main.async{
                                self.sendMessage(content: userResponse.message!)
                                print("got error code:\(userResponse.code) - Message:\(userResponse.message)")
                            }
                        }
                    }
                } else {
                    //json parsing errors here
                    print(error?.localizedDescription)
                }
            })
            dataTask?.resume() //kick off the task
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

extension ViewController{
    func sendMessage(content:String){
        self.messageLabel.text = content
        self.messageLabel.alpha = 100.0
        UIView.animate(withDuration: 2.0, animations: {
            self.messageLabel.alpha = 0.0
        })
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.getResults();
        return true
    }
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
            cell.imageView?.sd_setImage(with:cellURL, completed:{
                (_,_,_,_) in
                self.collectionView?.collectionViewLayout.invalidateLayout()
            })
        }else{
            cell.imageView?.image = nil;
        }
        
        return cell
    }
    
}
