//
//  MemeEditPresenter.swift
//  MemeMe
//
//  Created by Paul Salinas on 2015-12-05.
//  Copyright © 2015 Paul Salinas. All rights reserved.
//

import Foundation
import UIKit

/* helper class that abstracts the modal presentation of meme edit controller to the navigation controller */
class MemeEditPresenter {
    var presenter: UIViewController
    
    init (presenter: UIViewController) {
        self.presenter = presenter
    }
    
    func present (meme: Meme?, animated: Bool, viewState: MemeEditViewController.initialViewState) {
        let editMemeController = presenter.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditViewController
        editMemeController.initialState = viewState
        editMemeController.meme = meme
        presenter.presentViewController(editMemeController, animated: animated, completion: nil)
    }
}