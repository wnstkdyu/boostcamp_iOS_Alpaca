//
//  SignUpViewController.swift
//  LoginScene
//
//  Created by Alpaca on 2017. 7. 10..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UITextViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selfIntrodutionTextView.backgroundColor = UIColor.darkGray
    }

    //MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var checkPwTextField: UITextField!
    @IBOutlet weak var selfIntrodutionTextView: UITextView!
    
    //MARK: Functions
    @IBAction func setPhotoFromLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the Keyboard
        idTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
        checkPwTextField.resignFirstResponder()
        selfIntrodutionTextView.resignFirstResponder()
        
        // Create UIImagePickerController instance
        let imagePickerController = UIImagePickerController()
        // Set the source of UIImagePickerController
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure SignUpViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker when the user canceled.
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Hide the Keyboard when the user taps background
    @IBAction func hideKeyboardWhenTappingBackground(_ sender: UITapGestureRecognizer) {
        // Hide the Keyboard
        idTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
        checkPwTextField.resignFirstResponder()
        selfIntrodutionTextView.resignFirstResponder()
    }
    
    // Modal dismiss
    @IBAction func cancelAndDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpAndDismiss(_ sender: Any) {
        // Check password
        if let pwText = pwTextField.text, let checkPwText = checkPwTextField.text {
            if pwText == checkPwText {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print("Check Password")
            }
        }
    }
    

}
