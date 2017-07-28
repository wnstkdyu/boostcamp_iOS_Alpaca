//
//  ItemCell.swift
//  Homepwner
//
//  Created by Alpaca on 2017. 7. 16..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFont(forTextStyle: .caption1)
        serialNumberLabel.font = caption1Font
    }
}
