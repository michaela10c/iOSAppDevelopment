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

let differences: [Position] = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]

enum CellState{
    case Empty, Died, Born, Alive
    
    func isLiving() -> Bool {
        switch self {
        case .Born, .Alive: return true
        default: return false
        }
    }
}

protocol GridProtocol {
    var rows: Int {get}
    var cols: Int {get}
    var gridCells: [Cell] {get}
    
    var living: Int {get}
    var died: Int{get}
    var alive: Int{get}
    var born: Int{get}
    var empty: Int{get}
    
    subscript (a: Int, b: Int) -> CellState {get set}
    
    func neighbors(position: Position) -> [Position]
    func livingNeighbors(position: Position) -> Int
}

protocol EngineDelegate: class {
    func engineDidUpdate(withGrid: GridProtocol)
}

protocol EngineProtocol {
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
            let position = Position($0/cols, $0%cols)
            return Cell(position, initialCell(position))
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
    
    func neighbors(position: Position) -> [Position] {
        return differences.map{(($0.row + rows + position.row), ($0.col + cols + position.col))}
    }
    
    func livingNeighbors(position: Position) -> Int {
        return gridCells.reduce(0, combine: {$1.state.isLiving() ? $0+1 : $0})
    }
}

class StandardEngine: EngineProtocol{
    private static var _sharedObj: StandardEngine = StandardEngine(10, 10)
    static var sharedObj = StandardEngine{
        get{return _sharedObj}
    }
    
    var grid: GridProtocol
    
    var rows: Int = 10{
        didSet{
            grid = Grid(rows: self.rows, cols: self.cols) {_,_ in .Empty}
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    var cols: Int = 20 {
        didSet {
            grid = Grid(rows: self.rows, cols: self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }

    weak var delegate: EngineDelegate?
    
}



