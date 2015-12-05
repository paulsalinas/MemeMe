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
    
    var memeDetailsPresenter: MemeDetailsPresenter!
    var memeEditPresenter: MemeEditPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = tableView.frame.height >= tableView.frame.width ? tableView.frame.height / 6 : tableView.frame.height / 3
        memeDetailsPresenter = MemeDetailsPresenter(presenter: self)
        memeEditPresenter = MemeEditPresenter(presenter: self)
        
        //show the edit meme dialog when the app first loads (this will be the first view that the app loads)
        memeEditPresenter.present(nil, animated: false, viewState: MemeEditViewController.initialViewState.AppLoad)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
       memeDetailsPresenter.present(memesCollection.memeAtIndex(indexPath.row))
    }
    
    /* IB Action Functions */
    @IBAction func createMeme(sender: AnyObject) {
        memeEditPresenter.present(nil, animated: true, viewState: MemeEditViewController.initialViewState.Create)
    }
    
}
