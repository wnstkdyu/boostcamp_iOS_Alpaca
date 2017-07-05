//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Alpaca on 2017. 6. 30..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    
    var fahrenheitValue: Double? {
        /* 프로퍼티 값이 바뀌면 update */
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
            
            celsiusLabel.text = numberFormatter.string(from: value as NSNumber)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBOutlet var textField: UITextField!
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        /* 배경 뷰를 터치했을 때 키보드가 내려가게끔 textField의 resignFirstResponder() 호출 */
        textField.resignFirstResponder()
    }
    
    @IBAction func fahrehheitFieldEditingChanged(textField: UITextField) {
        
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    /* textField 입력 값의 범위를 소수 첫째 자리만 받음 */
    /* 질문 필요! */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        let hasAlphabet = string.rangeOfCharacter(from: NSCharacterSet.letters) // 알파벳을 가지고 있으면 거기에 맞는 range 반환.
        
        if (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) || hasAlphabet != nil {
            return false
        }
        else {
            return true
        }
        
    }
    
    /* 숫자 포맷 지정자로 한 자리 소수점 수만을 표시 */
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
}
