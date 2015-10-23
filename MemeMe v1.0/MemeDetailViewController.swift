//
//  MemeDetailViewController.swift
//  MemeMe v1.0
//
//  Created by André Servidoni on 9/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MemeDetailViewController: UIViewController, MemeEditorProtocol {
    
    var meme: Meme!
    var index: Int!
    
    @IBOutlet weak var memeDetailed: UIImageView!
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    // MARK: lifecycle functions
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        memeDetailed.image = UIImage(data: meme.memeImage)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editSegue" {
            
            let controller = segue.destinationViewController as! MemeEditorViewController
            
            controller.memeIndex = index
            controller.memeToEdit = meme
            controller.delegate = self
        }

    }
    
    // MARK: Action functions
    
    @IBAction func deleteMeme(sender: UIButton) {
        sharedContext.deleteObject(meme)
        CoreDataStackManager.sharedInstance().saveContext()
        
        navigationController!.popViewControllerAnimated(true)
    }
    
    // MARK: Delegate functions
    
    func finishToEdit(meme: Meme) {
        self.meme = meme
    }
}