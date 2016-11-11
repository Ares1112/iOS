//
//  ViewController.swift
//  Music
//
//  Created by Użytkownik Gość on 13.10.2016.
//  Copyright (c) 2016 Użytkownik Gość. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var albums: NSMutableArray = []
    var albumsDocPath: String = ""
    let plistPath = NSBundle.mainBundle().pathForResource("albums", ofType: "plist")!
    var selectedIndex = 0
    var isNew = false
    
    @IBAction func textArtistAction(sender: AnyObject) {
        enableSaving()
    }
    
    @IBAction func textTitleAction(sender: AnyObject) {
        enableSaving();
    }
    
    @IBAction func textGenreAction(sender: AnyObject) {
        enableSaving();
    }
    
    @IBAction func textYearAction(sender: AnyObject) {
        enableSaving();
    }
    
    @IBOutlet weak var stepRating: UIStepper!
    @IBOutlet weak var textYear: UITextField!
    @IBOutlet weak var textArtist: UITextField!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var textGenre: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    func enableSaving() {
        saveButton.enabled = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        albumsDocPath = documentsPath.stringByAppendingString("/albums.plist")
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(albumsDocPath)
        {
            try? fileManager.copyItemAtPath(plistPath, toPath: albumsDocPath)
        }
        albums = NSMutableArray(contentsOfFile: albumsDocPath)!
        reloadRecord();
        saveButton.enabled = false;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func stepperRatingAction(sender: AnyObject) {
        if stepRating.value < 0
        {
            stepRating.value = 0;
        }
        else if stepRating.value > 5
        {
            stepRating.value = 5;
        }
        else
        {
            saveButton.enabled = true
        }
        
        labelRating.text = NSString(format: "%.0f", stepRating.value) as String;
    }
    
    @IBAction func saveButtonAction(sender: AnyObject)
    {
        let newDic: NSDictionary = ["artist" : textArtist.text!, "title" : textTitle.text!, "date" : textYear.text!, "genre" : textGenre.text!, "rating" : labelRating.text!]
        if(isNew) {
            albums.addObject(newDic)
        } else {
            albums.replaceObjectAtIndex(selectedIndex, withObject: newDic)
        }
        albums.writeToFile(albumsDocPath, atomically: true)
    }

    
    @IBAction func deleteButtonAction(sender: AnyObject) {
        albums = NSMutableArray(contentsOfFile: albumsDocPath)!
        albums.removeObjectAtIndex(selectedIndex)
        albums.writeToFile(albumsDocPath, atomically: true)
    }
    
    
    @IBAction func cancelButtonAction(sender: AnyObject) {
    }
    
    
    func reloadRecord()
    {
        if(!isNew)
        {
            let artist = albums.objectAtIndex(selectedIndex).objectForKey("artist")
            textArtist.text = "\(artist!)";
            
            let title = albums.objectAtIndex(selectedIndex).objectForKey("title")
            if let title_ = title
            {
                textTitle.text = "\(title_)";
            }
            else{
                textTitle.text = "";
            }
            
            let genre = albums.objectAtIndex(selectedIndex).objectForKey("genre")
            textGenre.text = "\(genre!)";
            
            let year = albums.objectAtIndex(selectedIndex).objectForKey("date")
            if let year_ = year
            {
                textYear.text = "\(year_)";
            }
            else{
                textYear.text = ""
            }
            
            let rating = albums.objectAtIndex(selectedIndex).objectForKey("rating")
            if let rating_ = rating
            {
                labelRating.text = "\(rating_)";
                let rating2 = Double("\(rating_)");
                stepRating.value = rating2!;
            }
            else{
                labelRating.text = ""
            }
        }
        else
        {
            labelRating.text = "0";
            stepRating.value = 0
            textArtist.text = "";
            textGenre.text = "";
            textTitle.text = "";
            textYear.text = "";
            deleteButton.enabled = false
        }
    }
    
}

