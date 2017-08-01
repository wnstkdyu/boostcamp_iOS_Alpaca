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
    let baseURLString = ImageBoardAPI.baseURLString
    let request = Request()
    
    // MARK: Functions
    @IBAction func pressLoginButton(_ sender: Any) {
        let loginURLString = baseURLString + "/login"
        guard let loginURL = URL(string: loginURLString) else { return }
        
        
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
        
        let loginPostString = "email=\(email)&password=\(password)"
        guard let loginBody = loginPostString.data(using: .utf8) else { return }
        
        do {
            try request.post(url: loginURL, body: loginBody) {
                (data, response, error) -> Void in
                guard let httpResponse = response as? HTTPURLResponse else { return }
                switch httpResponse.statusCode {
                case 200:
                    // 성공
                    self.presentTableView()
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
