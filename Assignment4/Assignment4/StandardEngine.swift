//
//  StandardEngine.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation


class StandardEngine: EngineProtocol{
    private static var _sharedGridSize: StandardEngine{
        struct Dimensions{
            static var rows: Int = 10
            static var cols: Int = 10
        }
        return StandardEngine(rows: Dimensions.rows, cols: Dimensions.cols)
    }
    
    var delegate: EngineDelegate?
    
    var grid: GridProtocol = Grid(rows: 10, cols: 10, grid: Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: CellState.Empty)))//how should this be declared if it's like this? Is this how it's initialized?
    
    var refreshTimer: NSTimer?//if there is another timer, stop the timer. Otherwise, trigger it when it goes.
    
    var refreshRate = NSTimeInterval(0.0){
        didSet{
            if let refreshTimer = refreshTimer{refreshTimer.invalidate()}
            if refreshRate != 0.0{
            let sel = #selector(StandardEngine.rateChange(_:))
            refreshTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(refreshRate), target: self, selector: sel, userInfo: ["name": "Mike"], repeats: true)
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
    }
    
    
    func step() -> GridProtocol {//Is this the return?
        
        for r in 0..<rows{
            for c in 0..<cols{
                switch grid[r,c]{
                case .Born, .Living:
                    if aliveNeighbors(r, col: c)<2 || aliveNeighbors(r, col: c)>3{
                        grid[r,c] = .Living
                    }
                    else {
                        grid[r,c] = .Died
                    }
                default:
                    if aliveNeighbors(r, col: c)==3{
                        grid[r,c] = .Born
                    } else {
                        grid[r,c]  = .Empty
                        
                    }
                    cleanUp(r, col: c)
                }
            }
        }
        return grid
    }
    
    func aliveNeighbors(row: Int, col: Int) -> Int{//number of alive neighbors
        var liveNeighbors = 0
        for r in (-1...1){
            for c in (-1...1){
                if grid[wrap(r+row, col: c+col).0, wrap(r+row, col: c+col).1]==CellState.Born||grid[wrap(r+row, col: c+col).0, wrap(r+row, col: c+col).1]==CellState.Living{
                    liveNeighbors += 1
                }
            }
        }
        return liveNeighbors
    }
    
    func wrap(row: Int, col: Int) -> (Int,Int){//wrap the bounds
        var r = row
        var c = col
        if r == -1{r = rows-1}
        if r == rows{r = 0}
        if c == -1{c = cols-1}
        if c == cols{c = 0}
        return (r,c)
    }
    
    func cleanUp(row: Int, col: Int){//cleanup and decompose the cells
        switch  grid[row, col] {
        case .Born:
            grid[row, col] = .Living
        case .Died:
            grid[row, col] = .Empty
        default:
            break
        }
    }

    @objc func rateChange(timer: NSTimer){//NS Notification???? Params???
        let center = NSNotificationCenter.defaultCenter()
        let notification = NSNotification(name: "GridChanged", object: nil, userInfo: ["object": "grid"])//params???
        center.postNotification(notification)
    }
    
}