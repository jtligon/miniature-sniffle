//
//  CollectionViewCell.swift
//  FlickStream
//
//  Created by Jeff Ligon on 10/7/16.
//  Copyright © 2016 Jeff Ligon. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView:UIImageView?
    var imageURL:URL?
    
    @IBOutlet weak var textLabel: UILabel!
    
    func getImageFromUrl(url:URL){
        self.imageURL = url
        let data:Data = try! Data(contentsOf: url)
        self.imageView?.image = UIImage(data: data)
    }
    
}


