//
//  SignupViewController.swift
//  ImageBoard
//
//  Created by Alpaca on 2017. 7. 31..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

protocol SignupViewControllerDelegate {
    func presentCompleteAC()
}

class SignupViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var pwCheckTextField: UITextField!
    
    var signupViewControllerDelegate: SignupViewControllerDelegate?
    
    let request = Request()
    let baseURLString = ImageBoardAPI.baseURLString
    
    // MARK: Functions
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        nickNameTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
        pwCheckTextField.resignFirstResponder()
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard checkEmptyTextField() else { return }
        guard checkPwValidity() else { return }
        signupToServer(email: emailTextField.text!, password: pwTextField.text!, nickname: nickNameTextField.text!)
        
        navigationController?.popViewController(animated: true)
        signupViewControllerDelegate?.presentCompleteAC()
        
    }
    
    func checkEmptyTextField() -> Bool {
        guard
            emailTextField.text != "" &&
            nickNameTextField.text != "" &&
            pwTextField.text != "" &&
            pwCheckTextField.text != "" else {
                let alertMessage = "모든 항목을 입력해 주십시오."
                let ac = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
                
                let okayAction = UIAlertAction(title: "확인",
                                               style: .default,
                                               handler: {(action) -> Void in
                                                ac.dismiss(animated: true, completion: nil)
                })
                ac.addAction(okayAction)
                
                present(ac, animated: true, completion: nil)
                
                return false
        }
        
        return true
    }
    
    func checkPwValidity() -> Bool {
        if pwTextField.text != pwCheckTextField.text {
            let alertMessage = "암호와 암호확인이 일치하지 않습니다."
            let ac = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "확인",
                                           style: .default,
                                           handler: {(action) -> Void in
                                            ac.dismiss(animated: true, completion: nil)
            })
            ac.addAction(okayAction)
            
            present(ac, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    func signupToServer(email: String, password: String, nickname: String) {
        let signupURLString = baseURLString + "/user"
        guard let signupURL = URL(string: signupURLString) else { return }
        print("signupURL은 유효함!")
        
        let userData = UserInfo(_id: nil, nickname: nickname, password: password, email: email, __v: nil)
        do {
            let encodedUserData = try JSONEncoder().encode(userData)
            let encodedUserDataString = String(data: encodedUserData, encoding: .utf8)
            print(encodedUserDataString)
            do {
                try request.post(url: signupURL, body: encodedUserData) {
                    (data, response, error) -> Void in
                    guard let data = data else { return }
                    do {
                        let userData = try JSONDecoder().decode(UserInfo.self, from: data)
                        print(userData)
                    } catch {}
                }
            } catch {}
        } catch {}
        
//        do {
//            try request.post(url: signupURL, body: ) {
//                (data, response, error) -> Void in
//                guard let data = data else { return }
//                do {
//                    let userData = try JSONDecoder().decode(UserInfo.self, from: data)
//                    print(userData)
//                } catch {}
//            }
//        } catch {}
        
    }
}
