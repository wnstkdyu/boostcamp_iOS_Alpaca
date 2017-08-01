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
        
        let signupInfo = SignupInfo(email: email, password: password, nickname: nickname)
        guard let encodedSignupInfo = try? JSONEncoder().encode(signupInfo) else { return }
        
        do {
            try request.post(url: signupURL, body: encodedSignupInfo) {
                (data, response, error) -> Void in
                OperationQueue.main.addOperation {
                    guard let httpResponse = response as? HTTPURLResponse else { return }
                    switch httpResponse.statusCode {
                    case 201:
                        self.navigationController?.popViewController(animated: true)
                        self.signupViewControllerDelegate?.presentCompleteAC()
                    case 403:
                        let title = "알림"
                        let message = "Code: \(httpResponse.statusCode)\n" + "Message: \(httpResponse.allHeaderFields)\n"
                        
                        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        let okayAction = UIAlertAction(title: "확인", style: .default) { (action) -> Void in
                            ac.dismiss(animated: true, completion: nil)}
                        ac.addAction(okayAction)
                        
                        self.present(ac, animated: true, completion: nil)
                    default:
                        print(httpResponse.statusCode)
                        return
                    }
                }
            }
        } catch {}
    }
}
