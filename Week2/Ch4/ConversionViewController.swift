//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Alpaca on 2017. 7. 9..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    // 한 자리 소수점 수만 나오도록 하는 numberFormatter 설정
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    // 최대 하나의 소수점을 받도록
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 알파벳 문자 입력 받지 않게 하기
        guard string.rangeOfCharacter(from: CharacterSet.letters) == nil else {
            return false
        }
        
        // 소수점 두개 받지 않게 하기
        guard textField.text?.range(of: ".") != nil else {
            return true
        }
        guard string.range(of: ".") != nil else {
            return true
        }
        
        // 둘다 nil이 아닐 경우 false를 반환해야함.
        return false
        
       
        
        
    }
}
