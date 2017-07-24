//
//  HistoryStore.swift
//  OneToTwentyFive
//
//  Created by Alpaca on 2017. 7. 25..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class HistoryStore {
    var allHistory = [History]()
    
    func createEmptyHistory() {
        let newHistory = History()
        
        allHistory.append(newHistory)
    }
}
