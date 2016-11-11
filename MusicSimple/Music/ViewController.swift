//
//  ViewController.swift
//  Music
//
//  Created by Użytkownik Gość on 13.10.2016.
//  Copyright (c) 2016 Użytkownik Gość. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let plistCatPath =
    NSBundle.mainBundle().pathForResource("albums", ofType: "plist");
    var albums: NSMutableArray?;
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask,true)[0];
    let fileManager = NSFileManager.defaultManager();
    
    var currentPage = 1;
    
    var isNewRecord = false;
    var albumsDocPath: String = "";
    
    @IBOutlet weak var prevButton: UIButton!;
    @IBOutlet weak var recordLabel: UILabel!;
    
    @IBOutlet weak var nextButton: UIButton!;

    @IBOutlet weak var newButton: UIButton!;
    @IBOutlet weak var artistText: UITextField!;
    
    
    @IBOutlet weak var titleText: UITextField!;
    
    @IBOutlet weak var genreText: UITextField!;
    
    @IBOutlet weak var yearText: UITextField!;
    
    @IBAction func deleteButtonAction(sender: AnyObject) {
        albums?.removeObjectAtIndex(currentPage-1);
        reloadRecord();
        saveToFile();
    }
    @IBAction func nextButtonAction(sender: AnyObject) {
        currentPage += 1;
        
        if(currentPage >= (albums?.count)!+1) {
            nextButton.enabled = false;
        } else {
            nextButton.enabled = true;
        }
        if(currentPage == 1) {
            prevButton.enabled = false;
        } else {
            prevButton.enabled = true;
        }

        if(currentPage == (albums?.count)!+1) {
            newRecord();
        } else {
            reloadRecord();
        }
        
    }
    @IBAction func saveButtonAction(sender: AnyObject) {
        nextButton.enabled = true;
        saveToArray();
        saveToFile();
    }
    @IBOutlet weak var saveButton: UIButton!;
    @IBAction func prevButtonAction(sender: AnyObject) {
        if(currentPage != 1) {
            currentPage -= 1;
            
            reloadRecord();
        }
        if(currentPage >= (albums?.count)!+1) {
            nextButton.enabled = false;
        } else {
            nextButton.enabled = true;
        }	
        if(currentPage == 1) {
            prevButton.enabled = false;
        } else {
            prevButton.enabled = true;
        }
    }
    @IBAction func newRecordAction(sender: AnyObject) {
        newRecord();
    }
    @IBAction func artistAction(sender: AnyObject) {
        enableSaving();
    }
    @IBAction func titleAction(sender: AnyObject) {
        enableSaving();
    }
    @IBAction func genreAction(sender: AnyObject) {
        enableSaving();
    }
    @IBAction func yearAction(sender: AnyObject) {
        enableSaving();
    }
    @IBOutlet weak var ratingText: UILabel!;
    @IBOutlet weak var stepper: UIStepper!;
    
    @IBAction func ratingAction(sender: AnyObject) {
        enableSaving();
        ratingText.text = "\(Int(stepper.value))";
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        albumsDocPath = documentsPath.stringByAppendingString("/albums.plist");
        if (!fileManager.fileExistsAtPath(albumsDocPath)) {
        try? fileManager.copyItemAtPath(plistCatPath!, toPath: albumsDocPath)
        }
        albums = NSMutableArray(contentsOfFile:albumsDocPath);
        reloadRecord();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func reloadRecord() {
        
        isNewRecord = false;
        saveButton.enabled = false;
        newButton.enabled = true;
        recordLabel.text = "Record \(currentPage) of \(albums!.count)";
        let artist = albums?.objectAtIndex(currentPage-1).objectForKey("artist");
        artistText.text = "\(artist!)";
        let title = albums?.objectAtIndex(currentPage-1).objectForKey("title");
        titleText.text = "\(title!)";
        let date = albums?.objectAtIndex(currentPage-1).objectForKey("date");
        yearText.text = "\(date!)";
        let genre = albums?.objectAtIndex(currentPage-1).objectForKey("genre");
        genreText.text = "\(genre!)"
        let rating = albums?.objectAtIndex(currentPage-1).objectForKey("rating");
        ratingText.text = "\(rating!)";
        stepper.value = rating!.doubleValue;
        
        
        
    }
    
    func newRecord() {
        stepper.value = 0;
        recordLabel.text = "Record \(currentPage) of \(albums!.count)";
        artistText.text = "";
        titleText.text = "";
        yearText.text = "";
        genreText.text = "";
        ratingText.text = "0";
        isNewRecord = true;
        nextButton.enabled = false;
        newButton.enabled = false;
	
    }
    
    func enableSaving() {
        saveButton.enabled = true;
    }
    
    func saveToArray() {
        let newDic: NSDictionary = ["artist" : artistText.text!, "title" : titleText.text!, "date" : yearText.text!, "genre" : genreText.text!, "rating" : ratingText.text!];
        if(isNewRecord) {
        albums?.addObject(newDic);
        } else {
            albums?.replaceObjectAtIndex(currentPage - 1, withObject: newDic);
        }
        reloadRecord();
        
    }
    func saveToFile() {
        albums?.writeToFile(albumsDocPath, atomically: true);
    }

}

