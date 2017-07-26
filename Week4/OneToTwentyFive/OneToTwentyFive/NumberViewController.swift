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
    @IBOutlet weak var pressToStartBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var topRecordLabel: UILabel!
    @IBOutlet weak var topRecordNameLabel: UILabel!
    
    var numberArray = [8, 18, 4, 2, 5, 22, 15, 16, 11, 7, 25, 1, 23, 10, 12, 6, 13, 9, 21, 19, 3, 17, 24, 20, 14]
    var sortedNumberArray = [Int]()
    
    var timer: Timer?
    var startTime: Double = 0
    var finishTime: Date = Date()
    
    var newHistory = History()
    var historyStore = HistoryStore.sharedInstance

    
    // MARK: Function
    @IBAction func homeButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pressStartButton(_ sender: Any) {
        pressToStartBtn.isHidden = true
        
        // timer시작
        timerSet()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in numberButtonCollection {
            button.addTarget(self, action: #selector(gameLogic), for: .touchDown)
        }
        
        distributeNumber()
        sortedNumberArray = numberArray.sorted{ $0 < $1 }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTopRecord()
    }
    
    func distributeNumber() {
        for index in numberArray.indices {
            numberButtonCollection[index].setTitle("\(numberArray[index])", for: .normal)
        }
    }
    
    func gameLogic() {
        
        let selectedIndex: Int = whichButtonSelected(buttonArray: numberButtonCollection)
        guard let selectedNumber: Int = (numberButtonCollection[selectedIndex].titleLabel?.text as NSString?)?.integerValue else {
            assertionFailure("Cannot downcast")
            return
        }
        
        guard sortedNumberArray.first == selectedNumber else {
            print("Wrong order")
            
            return
        }
        sortedNumberArray.removeFirst()
        
        let selectedBtn = numberButtonCollection[selectedIndex]
        selectedBtn.isEnabled = false
        selectedBtn.backgroundColor = UIColor.white
        
        // 클리어 조건 검사
        if sortedNumberArray.count == 0 {
            print("Clear!")
            
            
            timer?.invalidate()
            pressToStartBtn.isHidden = false
            
            newHistory = History()
            showClearAlert()
            guard let finishTime = timeLabel.text else {
                return
            }
            newHistory.finishTime = finishTime
            newHistory.dateCreated = showNowDate()
            
            return
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
    
    func showClearAlert() {
        let title = "Clear!"
        let message = "Enter your name"
        let clearAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        clearAlert.addTextField(configurationHandler: nil)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel,
                                         handler: { (UIAlertAction) in
                                                self.resetGame()})
        let okayAction = UIAlertAction(title: "OK", style: .default,
                                       handler: { (UIAlertAction) in
                                                self.newHistory.name = (clearAlert.textFields?.first?.text)!;
                                                print(self.newHistory.name);
                                                self.historyStore.allHistory.append(self.newHistory)
                                                self.resetGame()})
        
        clearAlert.addAction(cancelAction)
        clearAlert.addAction(okayAction)
        
        present(clearAlert,
                animated: true,
                completion: nil)
        
    }
    
    func resetGame() {
        newHistory = History()
        for button in numberButtonCollection {
            button.isEnabled = true
            button.backgroundColor = UIColor.black
        }
        sortedNumberArray = numberArray.sorted{ $0 < $1 }
        
        updateTopRecord()
    }
    
    func updateTopRecord() {
        guard let topRecord = historyStore.topRecord else {
            topRecordLabel.text = "--:--:--"
            topRecordNameLabel.text = ""
            return
        }
        topRecordLabel.text = topRecord.finishTime
        topRecordNameLabel.text = topRecord.name
    }
    
    // time 관련
    func timerSet() {
        self.timer?.invalidate()
        self.timer = nil
        
        self.finishTime = Date()
        timeLabel.text = "00:00"
        
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.05,
                                     target: self,
                                     selector: #selector(updateTime),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func updateTime() {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "mm:ss:SS"
        
        let referenceDate = Date(timeIntervalSince1970: 0)
        finishTime = referenceDate + Date().timeIntervalSinceReferenceDate - startTime
        self.timeLabel.text = dateFormat.string(from: finishTime)
    }
    
    func showNowDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.mm.dd hh:mm:ss"
        
        let currentDate = dateFormatter.string(from: date)
        
        return currentDate
    }

}
