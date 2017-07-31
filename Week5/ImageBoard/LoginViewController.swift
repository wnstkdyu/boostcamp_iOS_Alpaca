//
//  LoginViewController.swift
//  ImageBoard
//
//  Created by Alpaca on 2017. 7. 31..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Mark: Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowSignup" else { return }
        guard let destinationVC = segue.destination as? SignupViewController else {
            return
        }
        print("델리게이트 설정 완료")
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
        print("회원가입 완료")
    }
}
