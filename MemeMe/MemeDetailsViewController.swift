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
    var memeEditPresenter: MemeEditPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the image for the view
        memeImage.image = meme.memedImage
        memeEditPresenter = MemeEditPresenter(presenter: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.hidden = false
    }
    
    /* on edit meme, show the edit meme view*/
    @IBAction func editMeme(sender: AnyObject) {
        memeEditPresenter.present(meme, animated: true, viewState: MemeEditViewController.initialViewState.Edit)
        navigationController?.popToRootViewControllerAnimated(true)
    }
}
