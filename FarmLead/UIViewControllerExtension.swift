//
//  UIViewControllerExtension.swift
//  FarmLead
//
//  Created by Zoumite Franck Armel Mamboue on 2016-08-09.
//  Copyright © 2016 Zoumite Franck Armel Mamboue. All rights reserved.
//
// This file contains utility functions specific to UIViewControllers

import UIKit

extension UIViewController {
    
    func dismissPopup() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}