//
//  ViewController.swift
//  OneToTwentyFive
//
//  Created by Alpaca on 2017. 7. 24..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let historyStore = HistoryStore.sharedInstance
    
    var filePath: String {
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return ""
        }
        print("\(url)")
        return url.appendingPathComponent("Data").path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadHistory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadHistory() {
        if let ourHistory = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [History] {
            self.historyStore.allHistory = ourHistory
        }
    }

}

