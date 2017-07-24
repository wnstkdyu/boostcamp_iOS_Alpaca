//
//  NumberViewController.swift
//  OneToTwentyFive
//
//  Created by Alpaca on 2017. 7. 24..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class NumberViewController: UIViewController {
    // MARK: Properties
    @IBOutlet var numberButtonCollection: [UIButton]!
    @IBOutlet var pressToStartBtn: UIButton!
    @IBOutlet var timeLabel: UILabel!
    
    var numberArray = [8, 18, 4, 2, 5, 22, 15, 16, 11, 7, 25, 1, 23, 10, 12, 6, 13, 9, 21, 19, 3, 17, 24, 20, 14]
    var sortedNumberArray = [Int]()
    
    
    // MARK: Function
    @IBAction func homeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pressStartButton(_ sender: Any) {
        pressToStartBtn.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in numberButtonCollection {
            button.addTarget(self, action: #selector(gameLogicStart), for: .touchDown)
        }
        
        distributeNumber()
        sortedNumberArray = numberArray.sorted{ $0 < $1 }
    }
    
    func distributeNumber() {
        for index in numberArray.indices {
            numberButtonCollection[index].setTitle("\(numberArray[index])", for: .normal)
        }
    }
    
    func gameLogicStart() {
        print(sortedNumberArray)
        let selectedIndex: Int = whichButtonSelected(buttonArray: numberButtonCollection)
        guard let selectedNumber: Int = (numberButtonCollection[selectedIndex].titleLabel?.text as NSString?)?.integerValue else {
            assertionFailure("Cannot downcast")
            return
        }
        
        if sortedNumberArray.first == selectedNumber {
            sortedNumberArray.removeFirst()
            
            let selectedBtn = numberButtonCollection[selectedIndex]
            selectedBtn.isEnabled = false
            selectedBtn.backgroundColor = UIColor.white
        } else {
            print("Wrong Order")
        }
        
    }
    
    func whichButtonSelected(buttonArray: [UIButton]) -> Int {
        var selectedIndex: Int = 0
        for index in buttonArray.indices {
            if buttonArray[index].isHighlighted == true {
                selectedIndex = index
            }
        }
        
        return selectedIndex
    }
}
