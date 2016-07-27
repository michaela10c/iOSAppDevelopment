//
//  Engine.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/23/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

//Inspired by Van's prototype

typealias Position = (row: Int, col: Int)
typealias Cell = (position: Position, state: CellState)


enum CellState{
    case Empty, Died, Born, Alive
    
    func isLiving() -> Bool {
        switch self {
        case .Born, .Alive: return true
        default: return false
        }
    }
}

protocol EngineDelegate: class {
    func engineDidUpdate(withGrid: GridProtocol)
}

protocol GridProtocol {
    var rows: Int {get}
    var cols: Int {get}
    var gridCells: [Cell] {get set}
    
    var living: Int {get}
    var died: Int{get}
    var alive: Int{get}
    var born: Int{get}
    var empty: Int{get}
    
    subscript (a: Int, b: Int) -> CellState {get set}
    
    func neighbors(position: Position) -> [Position]
    func livingNeighbors(position: Position) -> Int
}

protocol EngineProtocol : class{
    var rows: Int{get set}
    var cols: Int{get set}
    var grid: GridProtocol {get}
    weak var delegate: EngineDelegate? {get set}
    
    var refreshRate:  Double {get set}
    var refreshTimer: NSTimer? {get set}
    
    func step() -> GridProtocol
}

typealias InitialCell = (Position) -> CellState

struct Grid: GridProtocol{
    private(set) var rows: Int
    private(set) var cols: Int
    var gridCells: [Cell]
    
    var living: Int {return gridCells.reduce(0) {return $1.state.isLiving() ? $0 + 1 : $0}}
    var dead: Int {return gridCells.reduce(0) {return !$1.state.isLiving() ? $0 + 1 : $0}}
    var born: Int {return gridCells.reduce(0) {return $1.state == .Born ? $0 + 1 : $0}}
    var alive: Int {return gridCells.reduce(0) {return $1.state == .Alive ? $0 + 1 : $0}}
    var died: Int {return gridCells.reduce(0) {return $1.state == .Died ? $0 + 1 : $0}}
    var empty: Int {return gridCells.reduce(0) {return $1.state == .Empty ? $0 + 1 : $0}}
    
    init(rows: Int, cols: Int, initialCell: InitialCell = {_ in .Empty}){
        self.rows = rows
        self.cols = cols
        self.gridCells = (0..<rows*cols).map {
            return Cell(Position($0/cols, $0%cols), initialCell(Position($0/cols, $0%cols)))
        }
    }
    
    subscript (a: Int, b: Int) -> CellState{
        get{
            return gridCells[a*cols+b].state
        }
        set{
            gridCells[a*cols+b].state = newValue
        }
    }
    
    let differences: [Position] = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]
    
    func neighbors(position: Position) -> [Position] {
        return differences.map{(($0.row + rows + position.row), ($0.col + cols + position.col))}
    }
    
    func livingNeighbors(position: Position) -> Int {
        return gridCells.reduce(0, combine: {$1.state.isLiving() ? $0+1 : $0})
    }
}



class StandardEngine: EngineProtocol{
    private static var _sharedUpdates = StandardEngine(rows: 30, cols: 20)
    static var sharedUpdates: EngineProtocol{
        get{
            return _sharedUpdates
        }
    }
    
    
    var grid: GridProtocol
    weak var delegate: EngineDelegate?
    //weak - automatic garbage collection
    //Java, Python: at runtime, deallocate, memory
    //Apple: compiler controls the memory 4 u, release at compile time
    //Reference counting garbage collection
    
    private var _rows: Int
    var rows: Int{
        get{
        return _rows
        }
        set{
            grid = Grid(rows: self.rows, cols: self.cols) {_,_ in .Empty}
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    private var _cols: Int
    var cols: Int{
        get{
            return _cols
        }
        set{
            grid = Grid(rows: self.rows, cols: self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid)
                
            }
        }
    }

    
    
    var refreshRate: Double = 0.0
    
    var refreshTimer: NSTimer?
    
    required init(rows: Int, cols: Int) {
        self._rows = rows
        self._cols = cols
        grid = Grid(rows: rows, cols: cols)
    }
    
    func step() -> GridProtocol {
        var newGrid = Grid(rows: rows, cols: cols)
        newGrid.gridCells = grid.gridCells.map({
            switch grid.livingNeighbors(($0.row, $0.col)){
            case 2,3 where $1.isLiving(): return Cell(($0.row, $0.col), .Alive)
            case 3 where !$1.isLiving(): return Cell(($0.row, $0.col), .Born)
            case _ where $1.isLiving(): return Cell(($0.row, $0.col), .Died)
            default: return Cell(($0.row, $0.col), .Empty)
            }
        })
        grid = newGrid
        if let delegate = delegate{
            delegate.engineDidUpdate(grid)}
        return grid
    }
}



