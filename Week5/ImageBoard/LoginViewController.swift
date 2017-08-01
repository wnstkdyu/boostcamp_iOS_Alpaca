//
//  LoginViewController.swift
//  ImageBoard
//
//  Created by Alpaca on 2017. 7. 31..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    
    let baseURLString = ImageBoardAPI.baseURLString
    let request = Request()
    
    // MARK: Functions
    @IBAction func pressLoginButton(_ sender: Any) {
        guard let emailText = emailTextField.text else { return }
        guard let pwText = pwTextField.text else { return }
        
        loginToServer(email: emailText, password: pwText)
    
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowSignup" else { return }
        guard let destinationVC = segue.destination as? SignupViewController else {
            return
        }
        destinationVC.signupViewControllerDelegate = self
    }
    
    func loginToServer(email: String, password: String) {
        let loginURLString = baseURLString + "/login"
        guard let loginURL = URL(string: loginURLString) else { return }
        
        let loginDic: [String: String] = ["email": email, "password": password]
//        let loginPostString = "email=\(email)&password=\(password)"
//        guard let loginBody = loginPostString.data(using: .utf8) else { return }
        guard let loginBody = try? JSONEncoder().encode(loginDic) else { return }
        print(loginBody)
        do {
            try request.post(url: loginURL, body: loginBody) {
                (data, response, error) -> Void in
                OperationQueue.main.addOperation {
                    guard let httpResponse = response as? HTTPURLResponse else { return }
                    switch httpResponse.statusCode {
                    case 200:
                        // 성공
                        self.dismiss(animated: true, completion: nil)
                    case 401:
                        let title = "알림"
                        let message = "Code: \(httpResponse.statusCode)\n" + "Message: unauthorized\n"
                        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        
                        let okayAction = UIAlertAction(title: "확인", style: .default) { (action) -> Void in
                            ac.dismiss(animated: true, completion: nil)
                        }
                        ac.addAction(okayAction)
                        
                        self.present(ac, animated: true, completion: nil)
                    default:
                        print(httpResponse.statusCode)
                    }
                }
            }
        } catch {}
    }
    
    func presentTableView() {
        guard let tc = storyboard?.instantiateViewController(
            withIdentifier: "ImageBoardTableViewController") as? ImageBoardTableViewController else { return }
        present(tc, animated: true, completion: nil)
    }
}

extension LoginViewController: SignupViewControllerDelegate {
    func presentCompleteAC() {
        let ac = UIAlertController(title: nil, message: "회원가입 완료", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "확인", style: .default) {
            (alertAction) -> Void in
            ac.dismiss(animated: true, completion: nil) }
        ac.addAction(okayAction)
        present(ac, animated: true, completion: nil)
    }
}
