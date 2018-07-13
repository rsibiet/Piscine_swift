//
//  CollectionViewCell.swift
//  d03_photos
//
//  Created by Remy SIBIET on 08/02/2018.
//  Copyright © 2018 Remy SIBIET. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var img : UIImage? {
        didSet {
            if let i = img {
                imageView?.image = i
            }
        }
    }
}
