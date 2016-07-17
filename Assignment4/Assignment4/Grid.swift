//
//  Grid.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation

enum CellState: String{
    case Born = "Born"
    case Living = "Living"
    case Died = "Died"
    case Empty = "Empty"
}

class Grid: GridProtocol{
   
    var rows: Int
    var cols: Int
    var grid: [[CellState]]
    required init(rows: Int, cols: Int, grid: [[CellState]]){
        self.rows = rows
        self.cols = cols
        self.grid = Array(count: rows, repeatedValue: Array(count: cols, repeatedValue: .Empty))
    }
    
    func neighbors(row: Int, col: Int) -> [(Int, Int)] {
        var neighbors: [(Int,Int)] = []
        let standeng = StandardEngine(rows: rows, cols: cols)
        for r in (-1...1){
            for c in (-1...1){
                neighbors.append((standeng.wrap(row+r, col: col+c)))
            }
        }
        return neighbors
    }
    
    subscript(row: Int, col: Int)-> CellState{
        get{
            return grid[row][col]
        }
        set{
            grid[row][col] = newValue
        }
    }
    
    
}
