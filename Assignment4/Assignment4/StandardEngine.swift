//
//  StandardEngine.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation


class StandardEngine: EngineProtocol{
   // var grid: GridProtocol
    private static var _sharedGridSize = StandardEngine(rows: 4, cols: 4)
    static var sharedGridSize: StandardEngine{//is this how I call this singleton?
        get{
            return _sharedGridSize
        }
    }
    var grid: GridProtocol
    var delegate: EngineDelegate?
    
   //how should this be declared if it's like this? Is this how it's initialized? Rows, cols, and so on in singleton? How should that be modified?
    
    var refreshTimer: NSTimer?//if there is another timer, stop the timer. Otherwise, trigger it when it goes.
    
    var refreshRate = NSTimeInterval(0.0){
        didSet{
            if let refreshTimer = refreshTimer{refreshTimer.invalidate()}
            if refreshRate != 0.0{
            let sel = #selector(StandardEngine.rateChange(_:))
            refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate, target: GridView(), selector: sel, userInfo: ["name": refreshRate], repeats: true)
            }
            else if let refreshTimer = refreshTimer{
                refreshTimer.invalidate()
                self.refreshTimer = nil//make the timer nil
            }
            
        }
    }
    var rows: Int{
        didSet{
            if let delegate = delegate{
                print("Hello!")
                delegate.engineDidUpdate(grid)//send notification about the update
            }
        }
    }
    var cols: Int{
        didSet{
            if let delegate = delegate{
                delegate.engineDidUpdate(grid)
            }
        }
    }
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        grid = Grid(rows: rows, cols: cols)
    }
   
    func step() -> GridProtocol {//I think this is how you return it, right?
        let newGrid = Grid(rows: grid.rows, cols: grid.cols)
        for r in 0..<grid.rows{
            for c in 0..<grid.cols{
                switch neighborsAlive(r, col: c){
                case 2:
                    if grid[r,c] == .Living || grid[r,c] == .Born {newGrid[r,c] = .Living}
                    else {grid[r,c] = .Died}
                case 3:
                    if grid[r,c] == .Died || grid[r,c] == .Empty {newGrid[r,c] = .Born}
                    else{newGrid[r,c] = .Living}
                default:
                    newGrid[r,c] = .Empty
                }
                cleanUp(r, col: c)
                print("\(r),\(c): \(neighborsAlive(r, col: c))")
            }
        }
        grid = newGrid
        return grid
    }
    
    func neighborsAlive(row: Int, col: Int) -> Int{
        var liveNeighbors = 0
        let gridClass = Grid(rows: grid.rows, cols: grid.cols)
        for r in gridClass.neighbors(row, col: col){
            switch grid[(row+r.0+grid.rows)%grid.rows,(col+r.1+grid.cols)%cols]{
            case .Living, .Born:
                liveNeighbors += 1
            default:
                break
            }
        }
        return liveNeighbors
    }
    
    
    func cleanUp(row: Int, col: Int){//cleanup and decompose the cells
        switch grid[row, col] {
        case .Born:
            grid[row, col] = .Living
        case .Died:
            grid[row, col] = .Empty
        default:
            break
        }
    }

    @objc func rateChange(timer: NSTimer){
        step()
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "ChangeGrid", object: refreshRate, userInfo: ["Rate": refreshRate]))
        
        print("Here it is!")
    }
}
