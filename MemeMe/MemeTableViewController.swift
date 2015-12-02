//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Paul Salinas on 2015-11-22.
//  Copyright © 2015 Paul Salinas. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    var memesCollection: MemesCollection {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memesCollection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show the edit meme dialog when the app first loads (this will be the first view that the app loads)
        showEditMeme(MemeEditViewController.initialViewState.AppLoad, animated: false, meme: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.rowHeight = tableView.frame.height / 6
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //remove the meme to the shared data model
        memesCollection.removeMemeAtIndex(indexPath.row)
        
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memesCollection.numberOfMemes()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell") as! MemeTableViewCell
        let meme = memesCollection.memeAtIndex(indexPath.row)
        
        // Set the name and image
        cell.memeImage?.image = meme.originalImage
        cell.topLabel.attributedText = NSAttributedString(string: meme.topText, attributes: Meme.getTextAttributes(20))
        cell.bottomLabel.attributedText = NSAttributedString(string: meme.bottomText, attributes: Meme.getTextAttributes(20))
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        showEditMeme(MemeEditViewController.initialViewState.Edit, animated: true, meme: memesCollection.memeAtIndex(indexPath.row))
    }
    
    /* IB Action Functions */
    @IBAction func editTableRows(sender: AnyObject) {
        tableView.allowsMultipleSelectionDuringEditing = false
    }
    
    @IBAction func createMeme(sender: AnyObject) {
        showEditMeme(MemeEditViewController.initialViewState.Create, animated: true, meme: nil)
    }
    
    func showEditMeme(state: MemeEditViewController.initialViewState, animated: Bool, meme: Meme?) {
        let editMemeController = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditViewController
        editMemeController.initialState = state
        editMemeController.meme = meme
        presentViewController(editMemeController, animated: animated, completion: nil)
    }
}
