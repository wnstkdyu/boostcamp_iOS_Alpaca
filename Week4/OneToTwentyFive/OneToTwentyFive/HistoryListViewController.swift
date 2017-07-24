//
//  HistoryListViewController.swift
//  OneToTwentyFive
//
//  Created by Alpaca on 2017. 7. 25..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class HistoryListViewController: UIViewController {
    
    var historyStore = HistoryStore()
    
    
    @IBAction func pressCloseBtn(_ sender: Any) {
        if self == navigationController?.topViewController {
            navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
