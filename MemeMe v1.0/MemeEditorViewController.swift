//
//  ViewController.swift
//  MemeMe v1.0
//
//  Created by André Servidoni on 9/16/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import CoreData

// protocol responsible to send the edited meme back
// to the MemeDetailViewController
protocol MemeEditorProtocol {
    func finishToEdit(meme: Meme)
}

class MemeEditorViewController: UIViewController, FontViewProtocol {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    var pickerDelegate: ImagePickerDelegate!
    var topTextDelegate: TopTextFieldDelegate!
    var bottomTextDelegate: BottomTextFieldDelegate!
    
    var delegate: MemeEditorProtocol?
    
    let TOP_MESSAGE = "TOP"
    let BOTTOM_MESSAGE = "BOTTOM"
    
    // variables for edition
    var memeToEdit: Meme?
    var memeIndex: Int!
    var isEditing: Bool! = false
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -1.0
    ]
    
    lazy var temporaryContext: NSManagedObjectContext = {
        //let temporary = NSManagedObjectContext()
        //temporary.persistentStoreCoordinator = CoreDataStackManager.sharedInstance().
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit;
        
        pickerDelegate = ImagePickerDelegate(view: imageView)
        topTextDelegate = TopTextFieldDelegate()
        bottomTextDelegate = BottomTextFieldDelegate(screenView: view)
        
        topTextField.delegate = topTextDelegate
        bottomTextField.delegate = bottomTextDelegate
        
        setupTextField(topTextField, withText: TOP_MESSAGE)
        setupTextField(bottomTextField, withText: BOTTOM_MESSAGE)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // set the values of the meme that we want to edit
        if let temp = memeToEdit {
            imageView.image = UIImage(data: temp.originalImage)
            topTextField.text = temp.textTop
            bottomTextField.text = temp.textBottom
            isEditing = true
        }
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        shareButton.enabled = imageView.image != nil
    }
    
    // set the parameter of the view when the segue is executed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // we have only 1 segue so we don't need the if to verify which segue is
        let controller = segue.destinationViewController as! FontViewController
        controller.delegate = self
    }
    
    // make this view controller to be full screen
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: protocol functions
    
    // set the font of the textfield after the user chooses it
    func fontChoosed(font: String) {
        topTextField.font = UIFont(name: font, size: 40)
        bottomTextField.font = UIFont(name: font, size: 40)
    }

    //MARK: Action functions
    
    // open the image picker controller from the library
    @IBAction func pickImageFromLibrary(sender: UIBarButtonItem) {
        openPicker(ofType: UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    // open the image picker controller from the camera
    @IBAction func pickImageFromCamera(sender: UIBarButtonItem) {
        openPicker(ofType: UIImagePickerControllerSourceType.Camera)
    }

    // share the meme image created
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        let generated = generateMeme()
        
        let nextController = UIActivityViewController(activityItems: [generated], applicationActivities: nil)
        nextController.completionWithItemsHandler = { activity, success, items, error in
            
            if(success) {
                self.saveMeme(generated)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        presentViewController(nextController, animated: true, completion: nil)
    }
    
    // reset the UI
    @IBAction func resetUI(sender: UIBarButtonItem) {
        // called the setupTextField function again because we need to reset the font too
        setupTextField(topTextField, withText: TOP_MESSAGE)
        setupTextField(bottomTextField, withText: BOTTOM_MESSAGE)
        imageView.image = nil
        shareButton.enabled = false
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Private functions
    
    // setup the text fields with the desired properties
    private func setupTextField(field: UITextField, withText text: String!) {
        field.text = text
        field.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        field.defaultTextAttributes = memeTextAttributes
        field.textAlignment = NSTextAlignment.Center
    }
    
    // open the picker with the desired source type
    private func openPicker(ofType type: UIImagePickerControllerSourceType!) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = pickerDelegate
        pickerController.sourceType = type
        
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    // create the meme object
    private func saveMeme(generated: UIImage) {
        let meme = Meme(top: topTextField.text!, bottom: bottomTextField.text!, original: imageView.image!, altered: generated, context: temporaryContext)
        
        if(isEditing == true) {
            delegate?.finishToEdit(meme)
        } else {
            CoreDataStackManager.sharedInstance().saveContext()
        }
    }
    
    // generate the meme image
    private func generateMeme() -> UIImage {
        
        setToolbarHidden(true)
        
        UIGraphicsBeginImageContext(view.frame.size)
        
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        
        let generatedImage : UIImage!
        generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        setToolbarHidden(false)
        
        return generatedImage
    }
    
    // hide or show the toolbars
    private func setToolbarHidden(isHidden: Bool) {
        topToolbar.hidden = isHidden
        bottomToolbar.hidden = isHidden
    }

}

