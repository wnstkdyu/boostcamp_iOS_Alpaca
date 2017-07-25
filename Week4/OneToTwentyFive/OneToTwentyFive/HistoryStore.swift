//
//  HistoryStore.swift
//  OneToTwentyFive
//
//  Created by Alpaca on 2017. 7. 25..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class HistoryStore {
    static let sharedInstance = HistoryStore()
    var allHistory: [History] = [] {
        didSet {
            let sortedHistory = self.allHistory.sorted{ $0.0.finishTime < $0.1.finishTime }
            allHistory = sortedHistory
            if let firstRecord = self.allHistory.first {
                topRecord = firstRecord
            }
        }
    }
    
    var topRecord = History()
    
    init() { }
}
