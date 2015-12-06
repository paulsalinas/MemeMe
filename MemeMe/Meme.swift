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
    
    /* the text attributes for the text labels in the meme */
    static func getTextAttributes(fontSize: CGFloat) -> [String: NSObject]
    {
        return [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: fontSize)!,
            NSStrokeWidthAttributeName : -3.0
        ]
    }
    
}