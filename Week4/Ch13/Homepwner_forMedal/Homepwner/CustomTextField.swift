//
//  CustomTextField.swift
//  Homepwner
//
//  Created by Alpaca on 2017. 7. 24..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        changeBorder()
        print("TextField became firstResponder")
        
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        resetBorder()
        print("Textfield resign firstResponder")
        
        return true
    }
    
    func changeBorder() {
        self.borderStyle = .none
    }
    
    func resetBorder() {
        self.borderStyle = .roundedRect
    }
}
