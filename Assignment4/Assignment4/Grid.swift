
//
//  Grid.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation

enum CellState{
    case Born, Living, Died, Empty
    func isLiving() -> Bool{
        switch self {
        case .Born, .Living: return true
        default: return false
        }
    }
}

class Grid: GridProtocol{
   
    private(set) var rows: Int
    private(set) var cols: Int
    var grid: [[CellState]] = [[]]
    required init(rows: Int, cols: Int){
        self.rows = rows
        self.cols = cols
        grid = Array(count:rows, repeatedValue:Array(count:cols, repeatedValue: CellState.Empty))
    }
    
    let ourNeighbors: [(Int,Int)] = [(-1,-1), (-1,0), (-1,1), (0,-1), (0,1), (1,-1), (1,0), (1,1)]

    func neighbors(row: Int, col: Int) -> [(Int,Int)] {
        return ourNeighbors.map{((row + rows + $0.0) % rows, (col + cols + $0.1) % cols)}
    }
    
    
    
    subscript(row: Int, col: Int)-> CellState{//OUT OF BOUNDS?
        get{
            return grid[row][col]
        }
        set{
            grid[row][col] = newValue
        }
    }
    
    
}
