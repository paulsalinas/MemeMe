//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Paul Salinas on 2015-11-22.
//  Copyright © 2015 Paul Salinas. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
 
    @IBAction func editTableRows(sender: AnyObject) {
        tableView.allowsMultipleSelectionDuringEditing = false
        //tableView.editing = true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //remove the meme to the shared data model
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.removeAtIndex(indexPath.row)
        
        tableView.reloadData()
    }
    
    
    @IBAction func createMeme(sender: AnyObject) {
        let viewController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditViewController
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.rowHeight = tableView.frame.height / 6
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell") as! MemeTableViewCell
        let meme = memes[indexPath.row]
        
        // Set the name and image
        cell.memeImage?.image = meme.originalImage
        cell.topLabel.attributedText = NSAttributedString(string: meme.topText, attributes: Meme.getTextAttributes(20))
        cell.bottomLabel.attributedText = NSAttributedString(string: meme.bottomText, attributes: Meme.getTextAttributes(20))
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditViewController
        viewController.meme = memes[indexPath.row]
        presentViewController(viewController, animated: true, completion: nil)
    }
}
