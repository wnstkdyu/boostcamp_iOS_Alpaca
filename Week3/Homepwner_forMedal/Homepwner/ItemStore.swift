//
//  ItemStore.swift
//  Homepwner
//
//  Created by Alpaca on 2017. 7. 15..
//  Copyright © 2017년 Alpaca. All rights reserved.
//

import UIKit

class ItemStore {
    // 아이템들을 저장할 배열
    var allItems = [Item]()
    
    // 5개의 임의의 물품을 추가하는 지정 이니셜라이저
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    // 새 물품을 만들고 반환하는 메서드 구현
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
}
