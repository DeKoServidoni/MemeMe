//
//  TopTextFieldDelegate.swift
//  MemeMe v1.0
//
//  Created by André Servidoni on 9/11/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

class TopTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // default values for the text fields
    let topText = "TOP"
    
    // verify if the textfield have the defaul text when the
    // user start to edit
    func textFieldDidBeginEditing(textField: UITextField) {
        
        var currentText = textField.text
        
        if currentText == topText {
            currentText = ""
        }
        
        textField.text = currentText
    }
    
    // dismiss the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField.text == "" {
            textField.text = topText
        }
        
        return true
    }
}