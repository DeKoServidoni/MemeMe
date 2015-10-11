//
//  CustomCollectionCell.swift
//  MemeMe v1.0
//
//  Created by André Servidoni on 9/23/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

class CustomCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var meme: UIImageView!
    
    func setMemeImage(image: UIImage!) {
        meme.image = image
    }
}