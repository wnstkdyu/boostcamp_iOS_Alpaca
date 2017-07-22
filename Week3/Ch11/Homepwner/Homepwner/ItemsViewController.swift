//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Alpaca on 2017. 7. 15..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    // ItemStore용 프로퍼티 추가
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        // 테이블뷰의 컨텐트 인셋과 스크롤 표시자의 인셋의 높이를 스테이터스 바의 높이와 같게 한다.
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
//        tableView.rowHeight = 65
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    // 표시해야 할 행의 개수를 리턴
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.updateLabels()
        
        // 물품 배열의 n번째에 있는 항목의 설명을 n과 row가 일치하는 셀의 텍스트로 설정한다
        // 이 셀은 테이블 뷰의 n번째 행에 나타난다.
        let item = itemStore.allItems[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    // 테이블 행 삭제하기
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 테이블 뷰가 삭제 명령의 적용을 요청하면
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            // alert의 메시지 작성
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            // actionSheet의 action 추가
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                             handler: { (action) -> Void in
                                                // 저장소에서 그 항목을 제거한다.
                                                self.itemStore.removeItem(item: item)
                                                // 또한 애니메이션과 함께 테이블 뷰에서 그 행을 제거한다.
                                                tableView.deleteRows(at: [indexPath], with: .automatic)})
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
            
//            // 저장소에서 그 항목을 제거한다.
//            itemStore.removeItem(item: item)
//            
//            // 또한 애니메이션과 함께 테이블 뷰에서 그 행을 제거한다.
//            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // 테이블 행 옮기기
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 모델을 업데이트한다.
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    // 테이블 헤더 뷰 구현
    @IBAction func addNewItem(sender: AnyObject) {
//        // 0번 섹션, 마지막 행의 인덱스 패스를 만든다.
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = IndexPath(row: lastRow, section: 0)
//        
//        // 테이블에 새로운 행을 삽입한다.
//        tableView.insertRows(at: [indexPath], with: .automatic)
        
        let newItem = itemStore.createItem()
        
        guard let index = itemStore.allItems.index(of: newItem) else {
            assertionFailure("index is nil")
            return
        }
        
        let indexPath = IndexPath(row: index, section: 0)
        
        // 테이블에 새로운 행을 삽입한다.
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            
            setEditing(true, animated: true)
        }
        
    }
}
