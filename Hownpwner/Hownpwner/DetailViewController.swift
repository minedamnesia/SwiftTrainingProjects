//
//  DetailViewController.swift
//  Hownpwner
//
//  Created by Kelly Yamamoto on 10/28/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var serialTextField: UITextField!
    
    @IBOutlet weak var valueTextField: UITextField!
    
    @IBOutlet weak var dateCreatedLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

    @IBAction func takePicture(sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        // If the device has a camera, take a picture; otherwise,
        // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
        
    }
    
    var imageStore: ImageStore!
    
    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
        }()
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
        }()
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String: AnyObject]) {
            // Get picked image from info dictionary
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            // Store the image in the ImageStore for the item's key
            imageStore.setImage(image, forKey:item.itemKey)
            
            // Put that image on the screen in the image view
            imageView.image = image
            
            
            // Take image picker off the screen -
            // you must call this dismiss method
            dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = item.name
        serialTextField.text = item.serialNumber
        valueTextField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        dateCreatedLabel.text = dateFormatter.stringFromDate(item.dateCreated)
        
        // Get the item key
        let key = item.itemKey
        
        // If there is an associated image with the item
        // display it on the image view
        let imageToDisplay = imageStore.imageForKey(key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //dismiss first responder
        view.endEditing(true)
        
        // "Save" changes to item
        item.name = nameTextField.text ?? ""
        item.serialNumber = serialTextField.text
        
        if let valueText = valueTextField.text,
            value = numberFormatter.numberFromString(valueText) {
                item.valueInDollars = value.integerValue
        }
        else {
            item.valueInDollars = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class ResponderBorderStyle : UITextField {

    override func becomeFirstResponder() -> Bool {
        self.borderStyle = .Line
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        self.borderStyle = .RoundedRect
        return super.becomeFirstResponder()
    }
}