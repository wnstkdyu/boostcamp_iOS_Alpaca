//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by Alpaca on 2017. 7. 24..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var item: Item = Item()
    
    
    @IBAction func dateChanged(_ sender: Any) {
        item.dateCreated = datePicker.date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.date = item.dateCreated
    }
    
}
