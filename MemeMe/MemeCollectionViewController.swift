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
    
    var memeDetailsPresenter: MemeDetailsPresenter!
    var memeEditPresenter: MemeEditPresenter!

    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        adjustFlowLayout(self.view.frame.size)
        memeDetailsPresenter = MemeDetailsPresenter(presenter: self)
        memeEditPresenter = MemeEditPresenter(presenter: self)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
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
        memeDetailsPresenter.present(memesCollection.memeAtIndex(indexPath.row))
    }
    
    @IBAction func createMeme(sender: AnyObject) {
        memeEditPresenter.present(nil, animated: true, viewState: MemeEditViewController.initialViewState.Create)
    }
    
    /* adjust flow layout based on size of the screen. typically portrait vs. landscape mode*/
    func adjustFlowLayout(size: CGSize) {
        guard let flowLayout = flowLayout else {
            return
        }
        
        let space: CGFloat = 1.5
        let dimension:CGFloat = size.width >= size.height ? (size.width - (5 * space)) / 6.0 :  (size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }

}
