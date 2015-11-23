//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Paul Salinas on 2015-11-22.
//  Copyright © 2015 Paul Salinas. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell")!
        let meme = memes[indexPath.row]
        
        // Set the name and image
        //cell.textLabel?.text = villain.name
        cell.imageView?.image = meme.memedImage
        
        // If the cell has a detail label, we will put the evil scheme in.
//        if let detailTextLabel = cell.detailTextLabel {
//            detailTextLabel.text = "Scheme: \(villain.evilScheme)"
//        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! ViewController
        let meme = memes[indexPath.row]
        viewController.imagePickerView.image = meme.originalImage
        viewController.topTextField.text = meme.topText
        viewController.bottomTextField.text = meme.bottomText
        navigationController!.pushViewController(viewController, animated: true)
}
