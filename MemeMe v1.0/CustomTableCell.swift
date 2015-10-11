//
//  CustomTableCell.swift
//  MemeMe v1.0
//
//  Created by André Servidoni on 9/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

class CustomTableCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var meme: UIImageView!
    
    func setContentWith(text: String!, andImage image: UIImage!) {
        label.text = text
        meme.image = image
    }
}