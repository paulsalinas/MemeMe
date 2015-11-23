//
//  Meme.swift
//  UIImagePickerExperiment
//
//  Created by Paul Salinas on 2015-10-31.
//  Copyright © 2015 Paul Salinas. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText, bottomText: String
    var originalImage, memedImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}