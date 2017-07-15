//
//  LoginViewController.swift
//  LoginScene
//
//  Created by Alpaca on 2017. 7. 2..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit
import FacebookLogin

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var signInUp_StackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        pwTextField.delegate = self
        
        // Facebook button add
        let loginButton = LoginButton(readPermissions: [.publicProfile])
        view.addSubview(loginButton)
        loginButton.center.x = view.center.x
        loginButton.center.y = view.center.y.adding(100.0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* 키보드 내려주기 */
    // 배경을 탭했을 때
    @IBAction func dismissKeyboard(_ sender: Any) {
        idTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField {
            pwTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        print("touch up inside - sign in")
        if let id = idTextField.text,
            let pw = pwTextField.text,
            !id.isEmpty && !pw.isEmpty{
                print("ID: \(id), PW: \(pw)")
            }
            else {
                print("ERROR!")
            }
    }
    
    @IBAction func signUp(_ sender: Any) {
        print("touch up inside - sign up")
    }
    
}

