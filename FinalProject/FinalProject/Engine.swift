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


enum CellState: Int {
    case Empty = 0, Born, Living, Dead
    
    func isLiving() -> Bool {
        switch self {
        case .Born, .Living: return true
        default: return false
        }
    }
}

protocol EngineDelegate: class {
    func engineDidUpdate(withGrid: GridProtocol)
    func engineDidUpdate(withConfigurations: [GridConfiguration])
}
extension EngineDelegate{
    func engineDidUpdate(withConfigurations: [GridConfiguration]){
        //default implementation
    }
}

protocol GridProtocol {
    var rows: Int {get}
    var cols: Int {get}
    var gridCells: [[CellState]] {get set}
    
    subscript (a: Int, b: Int) -> CellState {get set}
    
    func getNeighbors(position: Position) -> [Position]
    func getLivingNeighbors(position: Position) -> Int
    func getCount(desiredState: CellState) -> Int
}

protocol EngineProtocol{
    var rows: Int{get set}
    var cols: Int{get set}
    
    var configuration : GridConfiguration? {get set}
    var configurations : [GridConfiguration]{get set}
    
    var grid: GridProtocol {get set}
    weak var delegate: EngineDelegate? {get set}
    
    var refreshRate:  Double {get set}
    var refreshTimer: NSTimer? {get set}
    
    func step() -> GridProtocol
    
    func startTimer()
    func stopTimer()
    func emptyGrid() -> GridProtocol
}

typealias InitialCell = (Position) -> CellState

struct Grid: GridProtocol {
    var rows: Int
    var cols: Int
    var gridCells: [[CellState]]
    
    static let neighborOffsets: [Position] = [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        
        self.gridCells = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: CellState.Empty))
    }

    subscript (a: Int, b: Int) -> CellState {
        get{
            return gridCells[a][b]
        }
        set{
            gridCells[a][b] = newValue
        }
    }
    
    func getNeighbors(position: Position) -> [Position] {
        return Grid.neighborOffsets.map({ (offset) -> Position in
            var retVal = Position(row: position.row + offset.row , col: position.col + offset.col)
            
            // fix out of bounds row
            if (retVal.row < 0) {
                retVal.row = rows + retVal.row
            } else if (retVal.row >= rows) {
                retVal.row = retVal.row - rows
            }
            
            // fix out of bounds col
            if (retVal.col < 0) {
                retVal.col = cols + retVal.col
            } else if (retVal.col >= cols) {
                retVal.col = retVal.col - cols
            }
            
            return retVal
        })
    }
    
    func getLivingNeighbors(position: Position) -> Int {
        let neighborPositions = getNeighbors(position)
        
        return neighborPositions.reduce(0) { (count, neighborPosition) -> Int in
            gridCells[neighborPosition.row][neighborPosition.col].isLiving() ? count + 1 : count
        }
    }
    
    func getCount(desiredState: CellState) -> Int {
        return gridCells.reduce(0, combine: { (count, column) -> Int in
            return count + column.reduce(0, combine: { (count2, state) -> Int in
               state == desiredState ? count2 + 1 : count2
            })
        })
    }
}



class StandardEngine: EngineProtocol {
    static var sharedUpdates: EngineProtocol = StandardEngine(rows: 10, cols: 10)
    
    //used when parsing JSON, and then converted into points on the GridView.
    //GridConfiguration is a struct that takes in a configuration title and an array of points.
    var configuration : GridConfiguration?
    
    var configurations = [GridConfiguration](){
        didSet{
            delegate?.engineDidUpdate(configurations)
            
        }
    }
    
    var grid: GridProtocol{
        didSet{
         delegate?.engineDidUpdate(grid)
        }
    }
    
    weak var delegate: EngineDelegate?
    //weak - automatic garbage collection
    //Java, Python: at runtime, deallocate, memory
    //Apple: compiler controls the memory 4 u, release at compile time
    //Reference counting garbage collection
    
    var rows: Int {
        didSet {
            if self.rows < 10{self.rows = 10}
            grid = Grid(rows: self.rows, cols: self.cols)
            delegate?.engineDidUpdate(grid)
        }
    }
    
    var cols: Int {
        didSet{
            if self.cols < 10{self.cols = 10}
            grid = Grid(rows: self.rows, cols: self.cols)
            delegate?.engineDidUpdate(grid)
        }
    }
    
    var refreshRate: NSTimeInterval = 0.0{
        didSet{
            if refreshRate != 0{
                if let timer = refreshTimer{timer.invalidate()}
                refreshTimer = NSTimer.scheduledTimerWithTimeInterval(1/refreshRate, target: self, selector: #selector(timerDidFire), userInfo: ["Timer": refreshRate], repeats: true)
                NSNotificationCenter.defaultCenter().postNotificationName(timerStepNotification, object: nil, userInfo: ["Timer": refreshRate])
            }
            else if let timer = refreshTimer{timer.invalidate()}
        }
    }
    
    var refreshTimer: NSTimer?
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        grid = Grid(rows: rows, cols: cols)
    }
    
    func step() -> GridProtocol {
        var newGrid = Grid(rows: rows, cols: cols)
        
        newGrid.gridCells = grid.gridCells.enumerate().map({ (rowNumber, row) -> [CellState] in
            return row.enumerate().map({ (colNumber, state) -> CellState in
                let livingNeighborCount = grid.getLivingNeighbors(Position(row: rowNumber, col: colNumber))
                
                switch state {
                case .Living, .Born:
                    if livingNeighborCount == 2 || livingNeighborCount == 3 {
                        return .Living
                    } else {
                        return .Dead
                    }
                default:
                    if livingNeighborCount == 3 {
                        return .Born
                    } else {
                        return .Empty
                    }
                }
            })
        })
        grid = newGrid
        return newGrid
    }
    
    @objc func timerDidFire(timer: NSTimer){
        step()
    }
    
    func startTimer(){
        refreshTimer?.invalidate()
        refreshTimer = NSTimer.scheduledTimerWithTimeInterval(1/refreshRate, target: self, selector: #selector(timerDidFire), userInfo: ["Timer": refreshRate], repeats: true)
    }
    
    func stopTimer(){
        refreshTimer?.invalidate()
        NSNotificationCenter.defaultCenter().postNotificationName(timerStopNotification, object: nil, userInfo: ["Stop": refreshRate])
    }
    
    func emptyGrid() -> GridProtocol{
        var emptiedGrid = Grid(rows: rows, cols: cols)
        emptiedGrid.gridCells = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: CellState.Empty))
        grid = emptiedGrid
        return grid
    }
}



