//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Paul Salinas on 2015-11-22.
//  Copyright © 2015 Paul Salinas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController {
   
    var memesCollection: MemesCollection {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memesCollection
    }
    
    func showEditMeme(state: MemeEditViewController.initialViewState, animated: Bool, meme: Meme?) {
        let editMemeController = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditViewController
        editMemeController.initialState = state
        editMemeController.meme = meme
        presentViewController(editMemeController, animated: animated, completion: nil)
    }
    
    @IBAction func createMeme(sender: AnyObject) {
        showEditMeme(MemeEditViewController.initialViewState.Create, animated: true, meme: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    func adjustFlowLayout(size: CGSize) {
        let space: CGFloat = 1.5
        let dimension:CGFloat = size.width >= size.height ? (size.width - (5 * space)) / 6.0 :  (size.width - (2 * space)) / 3.0
    
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        adjustFlowLayout(self.view.frame.size)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        adjustFlowLayout(size)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memesCollection.numberOfMemes()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memesCollection.memeAtIndex(indexPath.item)
        
        cell.imageView.image = meme.originalImage
        cell.topLabel.text = meme.topText
        cell.topLabel.attributedText = NSAttributedString(string: meme.topText, attributes: Meme.getTextAttributes(12))
        cell.bottomLabel.text = meme.bottomText
        cell.bottomLabel.attributedText = NSAttributedString(string: meme.bottomText, attributes: Meme.getTextAttributes(12))
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        showEditMeme(MemeEditViewController.initialViewState.Edit, animated: true, meme: memesCollection.memeAtIndex(indexPath.item))
    }

}
