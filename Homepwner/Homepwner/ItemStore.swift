//
//  ItemStore.swift
//  Homepwner
//
//  Created by Michael Zhou on 7/24/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class ItemStore{
    var allItems = [Item]()
    
    //return new item
    func createItem() -> Item{
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    /*init() {
        for _ in 0..<5 {
            createItem()
        }
    }*/
    
    func deleteItem(item: Item){
        if let index = allItems.indexOf(item){
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        let movedItem = allItems[fromIndex]
        allItems.removeAtIndex(fromIndex)
        allItems.insert(movedItem, atIndex: toIndex)
    }
}