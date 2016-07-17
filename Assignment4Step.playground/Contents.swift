//: Playground - noun: a place where people can play

import UIKit



// From a playground

protocol SomeProtocol {
    
    var rows: Int {get set}
    
    var cols: Int {get set}
    
    init(rows: Int, cols: Int)
    
    
    
    subscript(row: Int, col: Int) -> Bool { get set }
    
}



class SomeImplementation : SomeProtocol {
    
    var rows: Int
    
    var cols: Int
    
    
    
    private var grid : [[Bool]]
    
    
    
    required init(rows: Int, cols: Int) {
        
        self.rows = rows
        
        self.cols = cols
        
        grid = Array(count: rows,
                     
                     repeatedValue: Array(count: cols,
                        
                        repeatedValue: false))
        
    }
    
    
    
    subscript(row: Int, col: Int) -> Bool {
        
        get {
            
            return grid[row][col]
            
        }
        
        set {
            
            grid[row][col] = newValue
            
        }
        
    }
    
}



let implTest = SomeImplementation(rows: 5, cols: 7)



implTest[0,5] = true

implTest[4,6] = true

var census = 0

let rowInt = implTest.rows

let colInt = implTest.cols

for row in 0..<implTest.rows {
    
    var printString = "     "
    
    for col : Int in 0..<implTest.cols {
        
        printString += (implTest[row, col] ? "X " : "O ")
        
        if implTest[row, col] {
            
            census += 1
            
        }
        
    }
    
    print (printString)
    
}

print ("   Census: \(census)")



// We can print this in the playground because the playground contains the SomeImplementation class and it's still in the same file, so private properties can still be seen.

implTest.grid



let protTest : SomeProtocol = implTest

// Once uncommented, this will fail, as the protocol doesn't have a grid object.

//protTest.grid

// This also won't work, as protTest is defined as a constant.

//protTest[2,3] = true

// The getter still works

protTest[0,5]

