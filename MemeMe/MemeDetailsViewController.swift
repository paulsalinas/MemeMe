//
//  MemeDetailsViewController.swift
//  MemeMe
//
//  Created by Paul Salinas on 2015-12-02.
//  Copyright © 2015 Paul Salinas. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {

   
    @IBOutlet weak var memeImage: UIImageView!
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the image for the view
        memeImage.image = meme.memedImage
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    @IBAction func editMeme(sender: AnyObject) {
        showEditMeme(MemeEditViewController.initialViewState.Edit, animated: true, meme: meme)  
    }
    
    
    func showEditMeme(state: MemeEditViewController.initialViewState, animated: Bool, meme: Meme?) {
        let editMemeController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditViewController
        editMemeController.initialState = state
        editMemeController.meme = meme
        presentViewController(editMemeController, animated: animated, completion: nil)
    }
}
