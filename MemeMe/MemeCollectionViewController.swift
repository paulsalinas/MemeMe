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
   
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    @IBAction func createMeme(sender: AnyObject) {
        let viewController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! ViewController
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        let width = view.frame.size.width
        let height = view.frame.size.height
        let space: CGFloat = width <= height ? 3.0 : 0
        let dimension: CGFloat =  width <= height ? (width - (2 * space)) / 3.0 : width / 6.0
        
        print(width)
        print(dimension)
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.item]
        
        cell.imageView.image = meme.originalImage
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let viewController = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! ViewController
        viewController.meme = memes[indexPath.row]
        presentViewController(viewController, animated: true, completion: nil)
    }

}
