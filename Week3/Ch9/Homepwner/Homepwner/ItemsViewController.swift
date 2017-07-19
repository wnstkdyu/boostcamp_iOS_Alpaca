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
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        // 물품 배열의 n번째에 있는 항목의 설명을 n과 row가 일치하는 셀의 텍스트로 설정한다
        // 이 셀은 테이블 뷰의 n번째 행에 나타난다.
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
}
