//
//  HistoryListViewController.swift
//  OneToTwentyFive
//
//  Created by Alpaca on 2017. 7. 25..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class HistoryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var nameAndDateLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    
    var historyStore = HistoryStore.sharedInstance
    
    @IBAction func pressCloseBtn(_ sender: Any) {
        if self == navigationController?.topViewController {
            navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func resetHistory(_ sender: Any) {
        historyStore.allHistory.removeAll()
        self.historyTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.historyTableView.dataSource = self
        self.historyTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let history = historyStore.allHistory[indexPath.row]
            historyStore.removeHistory(history: history)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyStore.allHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as? HistoryCell else {
            return HistoryCell()
        }
        
        let history = historyStore.allHistory[indexPath.row]
        
        cell.finishTimeLabel.text = history.finishTime
        cell.nameAndDateLabel.text = history.name + " " + history.dateCreated
        cell.nameAndDateLabel.textAlignment = .left
        print(history.name)
        
        return cell
    }
    
    
    
}
