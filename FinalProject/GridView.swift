//
//  GridView.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/26/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit


@IBDesignable class GridView: UIView {
    var engine = StandardEngine.sharedUpdates
    var points : [Position] = []
    var grid : [[CellState]]{
        get{//if the configuration exists...
            var cells = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: .Empty))
            if let configuration = engine.configuration{
                configuration.points.forEach({ point in
                    cells[point.0][point.1] = .Living
                })
            }
            else{
                cells = engine.grid.gridCells
            }
            
            return cells
        }
        set(newValue){
            if let _ = engine.configuration{
                var aliveCells = [(Int,Int)]()
                for row in 0..<rows{
                    for col in 0..<cols{
                        if newValue[row][col].isLiving(){
                            aliveCells.append((row,col))
                        }
                    }
                }
                engine.configuration?.points = aliveCells
                //update configurations array, update points too.
            }
            else{
                engine.grid.gridCells = newValue
            }
            
        }
    }
    
    var rows: Int{
        get{
            if let configuration = engine.configuration{//get the points, and then find the max integer
                let rowValues : [Int] = configuration.points.map({(tuple) -> Int in return tuple.0})
                
                if let maxRowVals = rowValues.maxElement(){
                    return max(maxRowVals + 1, 10)//This is the default number of cols, no more 1 by 1 grids!!!
                }
                else{
                    return 10
                }
            }
            //print("RowVal: \(engine.rows)")

            return engine.rows
        }
        set(newValue){
            guard (engine.configuration) == nil else{return}
            engine.rows = newValue
        }
    }
    
    var cols: Int{
        get{
            if let configuration = engine.configuration{
                let colValues : [Int] = configuration.points.map({(tuple) -> Int in return tuple.1})
                
                if let maxColVals = colValues.maxElement(){
                return max(maxColVals + 1, 10)//This is the default number of cols, no more 1 by 1 grids!!!
                }
                else{
                    return 10
                }
            }
           // print("ColVal: \(engine.cols)")
            return engine.cols
        }
        set(newValue){
            guard (engine.configuration) == nil else{return}
            engine.cols = newValue
        }
    }
    
    
    var cellWidth: CGFloat { get{return bounds.width/CGFloat(cols)}}
    var cellHeight: CGFloat { get{return bounds.width/CGFloat(rows)}}
    
    @IBInspectable var emptyColor: UIColor = UIColor.grayColor()
    @IBInspectable var livingColor: UIColor = UIColor.greenColor()
    @IBInspectable var bornColor: UIColor = UIColor.greenColor()
    @IBInspectable var diedColor: UIColor = UIColor.grayColor()
    
    let π: CGFloat = CGFloat(M_PI)
    var cell = Position(0,0)
    
    var swiped = false
    
    override func drawRect(rect: CGRect) {
        // TODO: add drawing code
        if rect.width == cellWidth-1{
            let state = getCellState(cell)
            getFillColor(state).setFill()
            fillPosition(cell)
            print("only one clicked")
        }
        else{
        for row in 0..<rows{
            for col in 0..<cols{
                fillPosition(Position(row,col))
                }
            }
            print("redrew whole grid")
        }
    }
    
    func fillPosition(pos: Position){
        let left = CGFloat(pos.col) * cellWidth
        let top = CGFloat(pos.row) * cellHeight
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 10.0)
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        let rect = CGRectMake(left, top, cellWidth-1, cellHeight-1)
        CGContextAddRect(context, rect)
        CGContextSetFillColorWithColor(context,
                                       getFillColor(getCellState(pos)).CGColor)
        CGContextFillPath(context)
    }
    
    func getFillColor(state: CellState) -> UIColor{
        switch state{
        case .Empty: return emptyColor
        case .Born: return bornColor
        case .Living: return livingColor
        case .Dead: return diedColor
        }
    }
    
    func getCellState(pos: Position) -> CellState{ 
        //print("\(grid[pos.row][pos.col])")
        return grid[pos.row][pos.col]
    }
    
    func getCell(p: CGPoint) -> Position{
        return Position(Int((p.y / bounds.height) * CGFloat(rows))%rows, Int((p.x / bounds.width) * CGFloat(cols))%cols)
    }

    //Drawing by dragging inspired by Karan's section
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.processTouch(touch)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            self.processTouch(touch)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //just stop whatever you are doing
    }
    
    func toggle(state: CellState)->CellState{
        switch state {
        case .Born, .Living: return .Empty
        default: return .Living
        }
    }
    
    func processTouch(touch: UITouch){
        let location = touch.locationInView(self)
        if cell.row >= 0 && cell.row < rows && cell.col >= 0 && cell.col < cols {
            // toggle touched cell in newGrid (replica of grid)
            cell = getCell(location)
            grid[cell.row][cell.col] = toggle(getCellState(cell))
            // send EngineUpdate notification
            
        }
        let rect = CGRectMake(CGFloat(cell.col)*cellWidth, CGFloat(cell.row)*cellHeight, cellWidth-1, cellHeight-1)
        setNeedsDisplayInRect(rect)
    }

    }

