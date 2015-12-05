//
//  MemesCollection.swift
//  MemeMe
//
//  Created by Paul Salinas on 2015-12-02.
//  Copyright © 2015 Paul Salinas. All rights reserved.
//

import Foundation

/*facade class the abstracts the meme collection*/
class MemesCollection {
    var memes = [Meme]()
    
    func numberOfMemes() -> Int {
        return memes.count
    }
    
    func memeAtIndex(row: Int) -> Meme {
        return memes[row]
    }
    
    func appendMeme(meme: Meme) {
        memes.append(meme)
    }
    
    func removeMemeAtIndex(row: Int) {
        memes.removeAtIndex(row)
    }
}
