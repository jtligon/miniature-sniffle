//
//  CollectionViewCell.swift
//  FlickStream
//
//  Created by Jeff Ligon on 10/7/16.
//  Copyright © 2016 Jeff Ligon. All rights reserved.
//

import UIKit
import SDWebImage
import QuartzCore

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView:UIImageView?
    var imageURL:URL?
    @IBOutlet weak var textLabel: UILabel!
    
    func getImageFromUrl(url:URL){
        self.imageURL = url
        
        self.imageView?.layer.cornerRadius = 25.0
        self.imageView?.sd_setImage(with:url)
                                    
//                                    completed:{
//        (imageView, error, cacheType, url) in
//            //can use this fun completion later
//        })
    }
    
}


