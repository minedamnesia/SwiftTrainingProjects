//
//  ItemStore.swift
//  Hownpwner
//
//  Created by Kelly Yamamoto on 10/27/15.
//  Copyright © 2015 Kelly Yamamoto. All rights reserved.
//

import UIKit
class ItemStore {
    var allItems = [Item]()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int){
        if fromIndex == toIndex {
            return
        }
        // get reference to what you moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        //remove item from array
        allItems.removeAtIndex(fromIndex)
        
        //insert item in new place
        allItems.insert(movedItem, atIndex: toIndex)
    }
}
