//
//  MemeDetailsPresenter.swift
//  MemeMe
//
//  Created by Paul Salinas on 2015-12-05.
//  Copyright © 2015 Paul Salinas. All rights reserved.
//

import Foundation
import UIKit

/* helper class that abstracts the "push" of meme details controller to the navigation controller */
class MemeDetailsPresenter {
    var presenter: UIViewController
    
    init (presenter: UIViewController) {
        self.presenter = presenter
    }
    
    func present (meme: Meme) {
        let detailsMemeController = presenter.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailsViewController") as! MemeDetailsViewController
        detailsMemeController.meme = meme
        presenter.navigationController!.pushViewController(detailsMemeController, animated: true)
    }
}
