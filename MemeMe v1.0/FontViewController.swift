//
//  FontViewController.swift
//  MemeMe v1.0
//
//  Created by André Servidoni on 9/16/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

// protocol responsible to communicate with the ViewController
// that call the FontViewController
protocol FontViewProtocol {
    func fontChoosed(font: String)
}

class FontViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: FontViewProtocol?
    
    var content: [String] = ["Apple Color Emoji", "Courier New", "Marker Felt" , "Helvetica Neue", "Times New Roman", "Copperplate"]
    
    // MARK: lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "itemContainer")
    }
    
    // MARK: table view delegate functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var line:UITableViewCell
        
        line = tableView.dequeueReusableCellWithIdentifier("itemContainer") as UITableViewCell!
        line.textLabel?.text = content[indexPath.row]
        
        return line
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let font = content[indexPath.row]
        delegate?.fontChoosed(font)
        
        closeViewController()
    }
    
    //MARK: action functions
    
    @IBAction func close(sender: AnyObject) {
        closeViewController()
    }
    
    //MARK: private functions
    
    private func closeViewController() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}