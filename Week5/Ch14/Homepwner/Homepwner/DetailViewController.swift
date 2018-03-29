//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Alpaca on 2017. 7. 23..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore = ImageStore()
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func takePicture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        
        // 기기에 카메라가 있으면 사진을 찍는다.
        // 아니면 사진 라이브러리에서 사진을 고른다.
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        let key = item.itemKey
        
        let imageToDisplay = imageStore.imageForKey(key: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 퍼스트 리스폰더를 정리한다.
        view.endEditing(true)
        
        // 변경 사항을 Item에 저장한다
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        guard let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) else {
                item.valueInDollars = 0
                return
            }
        item.valueInDollars = value.intValue
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension DetailViewController: UINavigationControllerDelegate {
}

extension DetailViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 딕셔너리에서 선택된 이미지를 가져온다.
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            assertionFailure("There is no image")
            return
        }
        // 이미지를 item의 키로 ImageStore 안에 저장한다.
        imageStore.setImage(image: pickedImage, forKey: item.itemKey)
        
        imageView.image = pickedImage
        dismiss(animated: true, completion: nil)
    }
}
