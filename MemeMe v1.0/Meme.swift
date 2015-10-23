//
//  Meme.swift
//  MemeMe v1.0
//
//  Created by André Servidoni on 9/11/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Meme: NSManagedObject {
    
    @NSManaged var textTop: String!
    @NSManaged var textBottom: String!
    @NSManaged var originalImage: NSData!
    @NSManaged var memeImage: NSData!
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(top: String, bottom: String, original: UIImage, altered: UIImage, context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Meme", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        textTop = top
        textBottom = bottom
        originalImage = UIImagePNGRepresentation(original)
        memeImage = UIImagePNGRepresentation(altered)
    }
}
