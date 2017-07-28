//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by Alpaca on 2017. 7. 24..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

protocol DatePickerDelegate: class {
    func didSelectDatePicker(date: Date)
}

class DatePickerViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var item: Item = Item()
    
    var datePickerDelegate: DatePickerDelegate?
    
    
    @IBAction func dateChanged(_ sender: Any) {
        item.dateCreated = datePicker.date
        call()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.date = item.dateCreated
    }
    
    func call() {
        datePickerDelegate?.didSelectDatePicker(date: datePicker.date)
    }
    
    
}
