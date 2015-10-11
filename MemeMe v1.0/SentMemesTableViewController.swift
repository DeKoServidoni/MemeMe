//
//  SentMemesTableViewController.swift
//  MemeMe v1.0
//
//  Created by André Servidoni on 9/23/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme]!
    
    // MARK: lifecycle functions
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        tableView!.reloadData()
    }
    
    // MARK: table view delegate functions
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var line:CustomTableCell!
        
        let text = memes[indexPath.row].textTop + " " + memes[indexPath.row].textBottom
        line = tableView.dequeueReusableCellWithIdentifier("itemTableContainer") as! CustomTableCell
        line.setContentWith(text, andImage: memes[indexPath.row].memeImage)
        
        return line
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let memeDetail = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailView") as! MemeDetailViewController
        
        memeDetail.meme = memes[indexPath.row]
        memeDetail.index = indexPath.row
        
        navigationController!.pushViewController(memeDetail, animated: true)
    }

}