//
//  BottomTextFieldDelegate.swift
//  MemeMe v1.0
//
//  Created by André Servidoni on 9/10/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

class BottomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // default values for the text field
    let bottomText = "BOTTOM"
    
    let container: UIView!
    
    init(screenView: UIView!) {
        container = screenView
    }
    
    // verify if the textfield have the defaul text when the
    // user start to edit
    func textFieldDidBeginEditing(textField: UITextField) {
        subscribeToKeyboardNotification()
        
        var currentText = textField.text
        
        if currentText == bottomText {
            currentText = ""
        }
        
        textField.text = currentText
    }
    
    // dismiss the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        unsubscribeFromKeyboardNotification()
        
        if textField.text == "" {
           textField.text = bottomText
        }
        
        return true
    }
    
    //MARK: keyboard layout functions
    
    // change the size of the view to move up when the keyboard appears
    func keyboardWillShow(notification: NSNotification) {
        container.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    // change the size of the view to move up when the keyboard disappears
    func keyboardWillDismiss(notification: NSNotification) {
        container.frame.origin.y = 0
    }
    
    // get the keyboard hight from the notification
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        
        return keyboardSize.CGRectValue().height
    }
    
    //MARK: notification functions
    
    // add a observer to the notification center so we can discover when the keyboard showed up
    private func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillDismiss:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // remove the observer from the notification center
    private func unsubscribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
}