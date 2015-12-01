//
//  ViewController.swift
//  UIImagePickerExperiment
//
//  Created by Paul Salinas on 2015-10-26.
//  Copyright © 2015 Paul Salinas. All rights reserved.
//

import UIKit

class MemeEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    @IBAction func cancelEdit(sender: AnyObject) {
        presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    var memedImage: UIImage!
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //camera button is enabled only if the environment contains a camera
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        //initialize top text field
        topTextField.defaultTextAttributes = Meme.getTextAttributes(40)
        topTextField.textAlignment = NSTextAlignment.Center
        topTextField.delegate = self
        
        //initialize bottom text field
        bottomTextField.defaultTextAttributes = Meme.getTextAttributes(40)
        bottomTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.delegate = self
        
        if let meme = meme  {
            
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
            imagePickerView.image = meme.originalImage
            shareButton.enabled = true
            return
        }
        
        shareButton.enabled = false
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
    }
    
    /* subcribe to keyboard events to fix the overlap between the keyboard and bottom text field */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    /* unsubcribe to the keyboard event here */
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
        shareButton.enabled = false
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil
    }
    
    /* launch activity view with the memed image as the activity item  */
    @IBAction func shareMemeImage(sender: AnyObject) {
        memedImage = generateMemedImage()
        let activityView = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityView.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
                self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
            }

            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        presentViewController(activityView, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
       pickAnImageHelper(UIImagePickerControllerSourceType.Camera)
    }
    
    @IBAction func pickAnImage(sender: AnyObject) {
        pickAnImageHelper(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    /* helper function to abstract the presentation of the image picker controller with a specific source type */
    func pickAnImageHelper(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    /* sets the chosen image from the imagePicker to the imageView */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imagePickerView.image = image
        dismissViewControllerAnimated(true, completion: nil)
        shareButton.enabled = true
    }
    
    /* close image picker on cancel */
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /* initialize the text fields */
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    /* shift the view up to accomodate the keyboard when editing the bottom text field */
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y =  getKeyboardHeight(notification) * -1
        }
    }
    
    /* shift the view to its orginal position when it's hidden */
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = 0
        }
    }
    
    /* calculate the height of the keyboard that triggered the notification */
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    /* subscribes the appropriate functions to keyboard notifications */
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    /* unsubcribes the appropriate functions to keyboard notifications */
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillHideNotification, object: nil)
    }
    
    /* generate meme image */
    func generateMemedImage() -> UIImage
    {
        
        //hide the toolbars before rendering the image
        topToolBar.hidden = true
        bottomToolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //unhide the toolbars
        topToolBar.hidden = false
        bottomToolBar.hidden = false
        
        return memedImage
    }
    
    /* save the current memeImage */
    func save() {
        //Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        //add the meme to the shared data model
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
   
}

