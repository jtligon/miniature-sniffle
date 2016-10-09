//
//  CollectionViewCell.swift
//  FlickStream
//
//  Created by Jeff Ligon on 10/7/16.
//  Copyright © 2016 Jeff Ligon. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView:UIImageView?
    var imageURL:URL?
    
    @IBOutlet weak var textLabel: UILabel!
    
    func getImageFromUrl(url:URL){
        self.imageURL = url
        
        self.imageView?.sd_setImage(with: url)
    }
    
}


