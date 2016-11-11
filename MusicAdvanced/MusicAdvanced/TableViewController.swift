//
//  TableViewController.swift
//  MusicAdvanced
//
//  Created by Arek on 02/11/2016.
//  Copyright © 2016 agh. All rights reserved.
//

import Foundation


import UIKit

class TableViewController: UITableViewController {
    
    var albums: NSMutableArray = []
    var albumsDocPath: String = ""
    let plistPath = NSBundle.mainBundle().pathForResource("albums",ofType: "plist")!
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    
    func loadData() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        albumsDocPath = documentsPath.stringByAppendingString("/albums.plist")
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(albumsDocPath)
        {
            try? fileManager.copyItemAtPath(plistPath, toPath: albumsDocPath)
        }
        albums = NSMutableArray(contentsOfFile: albumsDocPath)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TableViewRow"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TableViewRow
        
        let album = albums[indexPath.row]
        let artist = album.objectForKey("artist")
        let title = album.objectForKey("title")
        if let title_ = title
        {
            cell.labelTitle.text = "\(title_)"
        }
        else{
            cell.labelTitle.text = ""
        }
        if let artist_ = artist
        {
            cell.labelArtist.text = "\(artist_)"
        }
        else
        {
            cell.labelArtist.text = ""
        }
        
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! ViewController
        if(segue.identifier == "existing") {
            let index = tableView.indexPathForCell(sender as! TableViewRow)
            viewController.selectedIndex = index!.row
        } else if(segue.identifier == "new") {
            viewController.selectedIndex = 0
            viewController.isNew = true
            
        }
    }
    
    @IBAction func backAction(sender: UIStoryboardSegue) {
        loadData()
        tableView!.reloadData()
    }
    
    
}
