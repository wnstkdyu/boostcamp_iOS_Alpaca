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
    
    var numberArray: [Int] = {
        var tempArray = [Int]()
        for i in 1...25 {
            tempArray.append(i)
        }
        return tempArray
    }()
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateTopRecord()
    }
    
    func distributeNumber() {
        let randomArray = generateRandomArray(numArray: numberArray)
        
        for index in randomArray.indices {
            numberButtonCollection[index].setTitle("\(randomArray[index])", for: .normal)
        }
    }
    
    func generateRandomArray(numArray: [Int]) -> [Int] {
        var randomArray: [Int] = []
        var tempArray = numberArray
        while randomArray.count != 25 {
            let randomIndex: Int = Int(arc4random_uniform(25))
            guard tempArray[randomIndex] != 0 else { continue }
            randomArray.append(tempArray[randomIndex])
            tempArray[randomIndex] = 0
        }
        
        return randomArray
    }
    
    func gameLogic() {
        
        let selectedIndex: Int = whichButtonSelected(buttonArray: numberButtonCollection)
        guard let selectedNumber: Int = (numberButtonCollection[selectedIndex].titleLabel?.text as NSString?)?.integerValue else {
            assertionFailure("Cannot downcast")
            return
        }
        
        guard numberArray.first == selectedNumber else {
            print("Wrong order")
            
            return
        }
        numberArray.removeFirst()
        
        let selectedBtn = numberButtonCollection[selectedIndex]
        selectedBtn.isEnabled = false
        selectedBtn.backgroundColor = UIColor.white
        
        // 클리어 조건 검사
        if numberArray.count == 0 {
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
        numberArray = {
            var tempArray = [Int]()
            for i in 1...25{
                tempArray.append(i)
            }
            return tempArray
        }()
        
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
