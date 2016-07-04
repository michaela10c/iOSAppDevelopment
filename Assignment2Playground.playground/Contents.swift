//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

import Swift
import UIKit

enum Neighbors: Int{
    case zero = 0, one, two, three, four, five, six, seven, eight
}

struct Cell{
    var x = 0
    var y = 0
    var cells = Array(count:10, repeatedValue:
        Array(count:10, repeatedValue:Bool()))

    init(){
        for x in 0..<10{
            for y in 0..<10{
                if arc4random_uniform(3) == 1 {
                    cells[x][y] = true
                    print("\(cells)")
                }
            }
        }
        
    }
    
}



