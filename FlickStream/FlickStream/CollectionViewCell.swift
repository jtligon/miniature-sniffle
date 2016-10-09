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
    @IBOutlet weak var imageView:UIImageView?
    var imageURL:URL?
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0;
//        self.layer.shadowRadius = 5;
//        self.layer.shadowOffset = CGSize(width: 3, height: 3)
//        self.layer.shadowColor = UIColor.black.cgColor
    }
}


