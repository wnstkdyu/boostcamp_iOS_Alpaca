//
//  History.swift
//  OneToTwentyFive
//
//  Created by Alpaca on 2017. 7. 25..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import Foundation

class History: NSObject, NSCoding {
    var finishTime: String = ""
    var name: String = ""
    var dateCreated: String = ""
    
    struct Keys {
        static let finishTime = "finishTime"
        static let name = "name"
        static let dateCreated = "dateCreated"
    }
    
    override init() {
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let finishTimeObject = aDecoder.decodeObject(forKey: Keys.finishTime) as? String {
            finishTime = finishTimeObject
        }
        if let nameObject = aDecoder.decodeObject(forKey: Keys.name) as? String {
            name = nameObject
        }
        if let dateCreatedObject = aDecoder.decodeObject(forKey: Keys.dateCreated) as? String {
            dateCreated = dateCreatedObject
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(finishTime, forKey: Keys.finishTime)
        aCoder.encode(name, forKey: Keys.name)
        aCoder.encode(dateCreated, forKey: Keys.dateCreated)
    }
}
