//
//  SentMemesCollectionViewController.swift
//  MemeMe v1.0
//
//  Created by André Servidoni on 9/23/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SentMemesCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
    
    // MARK: lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2*space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        memes = fetchAllMemes()
        collectionView!.reloadData()
    }
    
    // MARK: Core data context
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    // MARK: private functions
    
    private func fetchAllMemes() -> [Meme] {
        
        do {
            let request = NSFetchRequest(entityName: "Meme")
            return try sharedContext.executeFetchRequest(request) as! [Meme]
        } catch let error as NSError {
            print("Error to fecth all memes! \(error)")
            return [Meme]()
        }
    }
    
    
    // MARK: collection view delegate functions
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let memeImage = UIImage(data: memes[indexPath.item].memeImage)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("itemCollectionContainer", forIndexPath: indexPath) as! CustomCollectionCell
        cell.setMemeImage(memeImage)
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let memeDetail = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailView") as! MemeDetailViewController
        
        memeDetail.meme = memes[indexPath.item]
        memeDetail.index = indexPath.item
        
        navigationController!.pushViewController(memeDetail, animated: true)
    }
    
}