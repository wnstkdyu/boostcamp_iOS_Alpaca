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
        
        // 상태 바의 높이를 얻는다.
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        // 테이블뷰의 컨텐트 인셋과 스크롤 표시자의 인셋의 높이를 스테이터스 바의 높이와 같게 한다.
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    // 표시해야 할 행의 개수를 리턴
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // itemStore 안의 item 갯수만큼 행을 반환
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        // 기본 모양을 가진 UITableViewCell 인스턴스를 만든다.
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
//        
        // 재사용 셀이나 새로운 셀을 얻는다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        // 물품 배열의 n번째에 있는 항목의 설명을 n과 row가 일치하는 셀의 텍스트로 설정한다
        // 이 셀은 테이블 뷰의 n번째 행에 나타난다.
        let item = itemStore.allItems[indexPath.row]
        
        /* 은메달 과제: 재정렬 막기 */
        // 마지막 행을 설정
        let lastRow = tableView.numberOfRows(inSection: 0) - 1
        let lastIndexPath = IndexPath(row: lastRow, section: 0)
        
        if indexPath == lastIndexPath {
            cell.textLabel?.text = "No more items!"
            cell.detailTextLabel?.text = "No value"
            
            return cell
        }
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        
        
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
            
            // 알림창 컨트롤러를 표시한다.
            present(ac, animated: true, completion: nil)
            
        }
    }
    
    // 테이블 행 옮기기
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
    /* 동메달 과제: Delete 버튼 이름 변경하기 */
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let item = itemStore.allItems[indexPath.row]
        
        // removeCell 버튼을 설정한다.
        let removeCellButton = UITableViewRowAction(style: .destructive, title: "Remove",
                                                    handler: { (action) -> Void in
                                                        // 저장소에서 그 항목을 제거한다.
                                                        self.itemStore.removeItem(item: item)
                                                        // 또한 애니메이션과 함께 테이블 뷰에서 그 행을 제거한다.
                                                        tableView.deleteRows(at: [indexPath], with: .automatic)})
        
        return [removeCellButton]
    }
    
    /* 은메달 과제: 재정렬 막기 */
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // 마지막 행은 움직일 수 없도록 구현
        let lastRow = tableView.numberOfRows(inSection: 0) - 1
        let lastIndexPath = IndexPath(row: lastRow, section: 0)
        
        if indexPath == lastIndexPath {
            return false
        } else {
            return true
        }
    }
    
    /* 금메달 과제: 재정렬 완전히 막기 */
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // 마지막 행은 수정 수 없도록 구현
        let lastRow = tableView.numberOfRows(inSection: 0) - 1
        let lastIndexPath = IndexPath(row: lastRow, section: 0)
        
        if indexPath == lastIndexPath {
            return false
        } else {
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        // 목적지가 마지막 인덱스보다 아래라면
        if proposedDestinationIndexPath.row >= tableView.numberOfRows(inSection: 0) - 1 {
            itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: proposedDestinationIndexPath.row - 1)
            return IndexPath(row: tableView.numberOfRows(inSection: 0) - 2, section: 0)
        } else {
            itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: proposedDestinationIndexPath.row)
            return proposedDestinationIndexPath
        }
    }
    
    // 테이블 헤더 뷰 구현
    @IBAction func addNewItem(sender: AnyObject) {
//        // 0번 섹션, 마지막 행의 인덱스 패스를 만든다.
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = IndexPath(row: lastRow, section: 0)
//        
//        // 테이블에 새로운 행을 삽입한다.
//        tableView.insertRows(at: [indexPath], with: .automatic)
        
        // 새 물품을 만들고 그것을 저장소에 추가한다.
        let newItem = itemStore.createItem()
        
        // 배열 안에서 이 항목의 위치를 계산한다.
        guard let index = itemStore.allItems.index(of: newItem) else {
            fatalError()
        }
        let indexPath = IndexPath(row: index - 1, section: 0)
        
        // 테이블에 새로운 행을 삽입한다.
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        // 현재 편집 모드이면
        if isEditing {
            // 사용자에게 상태를 알리기 위해 버튼의 텍스트를 변경한다.
            sender.setTitle("Edit", for: .normal)
            
            // 편집 모드를 끈다.
            setEditing(false, animated: true)
        } else {
            // 사용자에게 상태를 알리기 위해 버튼의 텍스트를 변경한다.
            sender.setTitle("Done", for: .normal)
            
            // 편집 모드로 들어간다.
            setEditing(true, animated: true)
        }
        
    }
}
