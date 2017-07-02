//
//  LoginViewController.swift
//  LoginScene
//
//  Created by Alpaca on 2017. 7. 2..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 키보드 내려주기
    @IBAction func dismissKeyboard(_ sender: Any) {
        idTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        print("touch up inside - sign in")
        if let id = idTextField.text, let pw = pwTextField.text {
            print("ID: \(id), PW: \(pw)")
        }
        
    }
    @IBAction func signUp(_ sender: Any) {
        print("touch up inside - sign up")
        if let id = idTextField.text, let pw = pwTextField.text {
            print("ID: \(id), PW: \(pw)")
        }
    }
    


}

