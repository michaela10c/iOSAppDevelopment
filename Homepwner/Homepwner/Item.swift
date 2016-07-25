//
//  Items.swift
//  Homepwner
//
//  Created by Michael Zhou on 7/24/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation


import UIKit

class Item: NSObject{
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: NSDate
    
    init(name: String, valueInDollars: Int, serialNumber: String?){
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        
        super.init()
    }
    
    convenience init(random: Bool = false){
        if random{
            let adj = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var index = arc4random_uniform(UInt32(adj.count))
            let randomAdj = adj[Int(index)]//cast to int from random
            
            index = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(index)]
            
            let randomName = "\(randomAdj) \(randomNoun)"
            let randomVal = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            
            self.init(name: randomName,
                      valueInDollars: randomVal, serialNumber: randomSerialNumber)
            
        } else {
            self.init(name: "",
                      valueInDollars: 0, serialNumber: nil)
        }
    }
    
    
    
}
