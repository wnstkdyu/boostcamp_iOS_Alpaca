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
    
    var myButton: MyButton = MyButton()
    var disableBtn: UIButton = UIButton()
    
    var isEnabled: Bool = true
    
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
        
        
        /* myButton */
        // myButton 인스턴스 생성
        
        view.addSubview(myButton)
        
        // myButton 제약조건 설정
        let margins = view.layoutMarginsGuide
        
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20.0).isActive = true
        myButton.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        myButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        myButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        
        /* disableBtn */
        // disableBtn 인스턴스 생성
        disableBtn = UIButton()
        
        view.addSubview(disableBtn)
        
        // disableBtn 설정
        disableBtn.setTitle("Disable the button", for: .normal)
//        disableBtn.setTitle("Able the button", for: .selected)
        
        disableBtn.setTitleColor(UIColor.black, for: .normal)
        disableBtn.setTitleColor(UIColor.black, for: .selected)
        disableBtn.titleLabel?.textAlignment = .center
        disableBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // disableBtn 제약조건 설정
        disableBtn.translatesAutoresizingMaskIntoConstraints = false
        disableBtn.topAnchor.constraint(equalTo: myButton.bottomAnchor).isActive = true
        disableBtn.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        disableBtn.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        disableBtn.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        // disableBtn func 설정
        disableBtn.addTarget(self, action: #selector (disableMyBtn(_:)), for: .touchUpInside)
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
//        if let id = idTextField.text,
//            let pw = pwTextField.text,
//            !id.isEmpty && !pw.isEmpty{
//                print("ID: \(id), PW: \(pw)")
//            }
//            else {
//                print("ERROR!")
//            }
        guard let id = idTextField.text, !id.isEmpty else {
            print("idTextField is empty!")
            return
        }
        guard let pw = pwTextField.text, !pw.isEmpty else {
            print("pwTextField is empty!")
            return
        }
        print("ID: \(id), PW: \(pw)")
    }
    
    @IBAction func signUp(_ sender: Any) {
        print("touch up inside - sign up")
    }
    
    func disableMyBtn(_ sender: UIButton) {
        // disable의 상태에따라
        if isEnabled {
            myButton.isUserInteractionEnabled = false
            myButton.backGroundImageView.alpha = 0.0
            
            disableBtn.setTitle("Enable the button", for: .normal)
            isEnabled = false
        } else {
            myButton.isUserInteractionEnabled = true
            myButton.backGroundImageView.alpha = 0.3
            
            disableBtn.setTitle("Disable the button", for: .normal)
            isEnabled = true
        }
    }
}

