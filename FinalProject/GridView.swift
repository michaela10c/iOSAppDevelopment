//
//  GridView.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/26/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit


@IBDesignable class GridView: UIView {
    
    var points : [Position] = []
    
   // var position = Position(0,0)
    
    var cellWidth: CGFloat { get{return bounds.width/CGFloat(StandardEngine.sharedUpdates.cols)}}
    var cellHeight: CGFloat { get{return bounds.width/CGFloat(StandardEngine.sharedUpdates.rows)}}
    
    @IBInspectable var emptyColor: UIColor = UIColor.grayColor()
    @IBInspectable var livingColor: UIColor = UIColor.greenColor()
    @IBInspectable var bornColor: UIColor = UIColor.greenColor()
    @IBInspectable var diedColor: UIColor = UIColor.grayColor()
    
    let π: CGFloat = CGFloat(M_PI)
    var cell = Position(0,0)
    
    
    
    var swiped = false
    //var lastPoint = CGPoint.zero
    
    override func drawRect(rect: CGRect) {
        // TODO: add drawing code
        if rect.width == cellWidth-1{
            let state = getCellState(cell)
            getFillColor(state).setFill()
            fillPosition(cell)
        }
        else{
        for row in 0..<StandardEngine.sharedUpdates.rows{
            for col in 0..<StandardEngine.sharedUpdates.cols{
                fillPosition(Position(row,col))
                }
            }
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
        return StandardEngine.sharedUpdates.grid[pos.row, pos.col]
    }
    
    func getCell(p: CGPoint) -> Position{
        return Position(Int((p.y / bounds.height) * CGFloat(StandardEngine.sharedUpdates.rows)), Int((p.x / bounds.width) * CGFloat(StandardEngine.sharedUpdates.cols)))
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.locationInView(self)
            cell = getCell(location)
            StandardEngine.sharedUpdates.grid[cell.row, cell.col] = toggle(getCellState(cell))
            let rect = CGRectMake(CGFloat(cell.col)*cellWidth, CGFloat(cell.row)*cellHeight, cellWidth-1, cellHeight-1)
            setNeedsDisplayInRect(rect)
            print("\(cell), \(getCellState(cell))")
        }
    }
    
    func toggle(state: CellState)->CellState{
        switch state {
        case .Born, .Living: return .Empty
        default: return .Living
        }
    }
    
}
