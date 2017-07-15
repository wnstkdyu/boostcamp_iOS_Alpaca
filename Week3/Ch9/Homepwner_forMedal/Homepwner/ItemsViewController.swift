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
    
    /* 동메달 과제: 테이블 섹션 구현
    // 섹션의 갯수 설정
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    */
    /* 동메다 과제 코드
    // 섹션의 제목 설정
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Over 50$"
        }
        return "ETC"
    }
    */
    
    // 표시해야 할 행의 개수를 리턴
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* 은메달 과제: 고정행 */
        return itemStore.allItems.count
        
        /* 동메달 과제 코드
        // 50달러 이상이면 "Over 50$"에, 그 외는 "ETC"에 넣는다.
        var over50Count: Int = 0
        for index in itemStore.allItems.indices {
            if itemStore.allItems[index].valueInDollars >= 50 {
                over50Count += 1
            }
        }
        
        // Section의 index별 행의 갯수 다르게 설정.
        switch section {
        case 0:
            return over50Count
        default:
            return itemStore.allItems.count - over50Count
        }
        */
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
//        let item = itemStore.allItems[indexPath.row]
//        
//        cell.textLabel?.text = item.name
//        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
//        
//        return cell
        
        /* 은메달 과제 코드 */
        // 원래의 itemStore의 item 숫자를 구한다.
        let originalItemCount = itemStore.allItems.count
        
        // 마지막 인덱스에서 No more items!가 출력되도록 한다.
        let item = itemStore.allItems[indexPath.row]
        switch indexPath.row {
        case originalItemCount - 1:
            cell.textLabel?.text = "No more items!"
            cell.detailTextLabel?.text = "No value"
            return cell
        default:
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            return cell
        }
        
        
        /* 동메달 과제 코드 */
//        
//        // 50달러 이상인 아이템들의 배열과 그 외의 배열을 만든다.
//        var over50CountArray = itemStore.allItems.filter{ $0.valueInDollars >= 50 }
//        var etcArray = itemStore.allItems.filter{ $0.valueInDollars < 50 }
//        
//        // Section 별로 cell을 다르게 설정
//        if indexPath.section == 0 {
//            let item = over50CountArray[indexPath.row]
//            
//            cell.textLabel?.text = item.name
//            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
//            
//            return cell
//        } else {
//            let item = etcArray[indexPath.row]
//            
//            cell.textLabel?.text = item.name
//            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
//            
//            return cell
//        }
        
    }
}
