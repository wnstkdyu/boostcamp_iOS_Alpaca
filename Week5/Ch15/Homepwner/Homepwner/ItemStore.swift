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
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = documentsDirectories.first else {
            return URL(fileURLWithPath: "")
        }
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems += archivedItems
        }
    }
    
    // 새 물품을 만들고 반환하는 메서드 구현
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    // 특정 항목을 제거하는 메서드 구현
    func removeItem(item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    // 배열의 항목 순서를 변경하는 메서드 구현
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // 다시 삽입할 수 있도록 이동할 객체의 레퍼런스를 얻는다.
        let movedItem = allItems[fromIndex]
        
        // 항목을 배열에서 제거한다.
        allItems.remove(at: fromIndex)
        
        // 항목을 배열에서 새 위치에 삽입한다.
        allItems.insert(movedItem, at: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
}
