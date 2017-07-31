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
        guard let url = URL(string: baseURLString) else { return }
        print("버튼눌림")
        request.get(url: url) {
            (data, response, error) in
            guard let data = data else { return }
            do {
                let info = try JSONDecoder().decode([UserInfo].self, from: data)
                print(info)
                print(response ?? "")
            } catch let error {
                print(error)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowSignup" else { return }
        guard let destinationVC = segue.destination as? SignupViewController else {
            return
        }
        destinationVC.signupViewControllerDelegate = self
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
