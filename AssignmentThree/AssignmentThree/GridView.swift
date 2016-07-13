//
//  GridView.swift
//  AssignmentThree
//
//  Created by Michael Zhou on 7/12/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {

    @IBInspectable var rows: Int = 20{
        didSet{
            _ = [[CellState]](count: rows, repeatedValue: Array(count: rows, repeatedValue: CellState.Empty))
        }
    }
    @IBInspectable var cols: Int = 20{
        didSet{
            _ = [[CellState]](count: rows, repeatedValue: Array(count: rows, repeatedValue: CellState.Empty))
        }
    }
    
    var grid = Array(count:20, repeatedValue:Array(count:20, repeatedValue: CellState.Empty))
    
    @IBInspectable var emptyColor: UIColor = UIColor.grayColor()
    @IBInspectable var livingColor: UIColor = UIColor.greenColor()
    @IBInspectable var bornColor: UIColor = UIColor.greenColor()
    @IBInspectable var diedColor: UIColor = UIColor.grayColor()
    @IBInspectable var gridWidth: CGFloat = 2.0
    let π: CGFloat = CGFloat(M_PI)
    
    var cellWidth: CGFloat{
        get{
            return bounds.width / CGFloat(cols)
        }
    }
    var cellHeight: CGFloat{
        get{
            return bounds.height / CGFloat(rows)
        }
    }
    
    var cell = (0,0)
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        if rect.width == cellWidth{
            fillPoint(cell.0, y: cell.1)
            
        } else {
            for x in 0..<rows{
                for y in 0..<rows{
                    fillPoint(x, y: y)
                    cell = (x,y)
                }
            }
        }
    }
    
    func fillPoint(x: Int, y: Int){
        let w: CGFloat = min(bounds.width, bounds.height)
        let h: CGFloat = 1.5
        let line = UIBezierPath()//grid lines
        line.lineWidth = h
        
        for xDiff in (0...1){
            line.moveToPoint(CGPoint(x: CGFloat(x+xDiff) * cellWidth, y: CGFloat(y) * cellHeight))
            line.addLineToPoint(CGPoint(x: CGFloat(x+xDiff) * cellWidth, y: CGFloat(y+1) * cellHeight))
            UIColor.brownColor().setStroke()
            line.stroke()
        }
        for yDiff in (0...1){
            line.moveToPoint(CGPoint(x: CGFloat(x) * cellWidth, y: CGFloat(y+yDiff) * cellHeight))
            line.addLineToPoint(CGPoint(x: CGFloat(x+1) * cellWidth, y: CGFloat(y+yDiff) * cellHeight))
            UIColor.brownColor().setStroke()
            line.stroke()
        }
        let cPath = UIBezierPath(arcCenter: findCenter(x, col: y),
                                 radius: (w / CGFloat(rows) / 2)-1,
                                 startAngle: 0, endAngle: 2 * π,
                                 clockwise: false)
        cPath.lineWidth = h
        getFill(grid[x][y])
        cPath.stroke()
        cPath.fill()
    }
 
    
    func findCenter (row: Int, col: Int) -> CGPoint{
        let x1 = CGFloat(col) * cellWidth
        let y1 = CGFloat(row) * cellHeight
        let x2 = x1 + cellWidth
        let y2 = y1 + cellHeight
        
        func cellRadius () -> CGFloat{
            return min(cellWidth/2.0, cellHeight/2.0)
        }
        return CGPoint(x: (x1+x2)/2, y: (y1+y2)/2)
    }

    func getFill(state: CellState){
        var color: UIColor
        switch state {
        case .Born:
            color = bornColor
        case .Empty:
            color = emptyColor
        case .Died:
            color = diedColor
        case .Living:
            color = livingColor
        }
        color.setStroke()
        color.setFill()
        //Don't forget the stroke and fill!!!!
    }
    
    func getCell(p:CGPoint)->(Int,Int){
        return (Int((p.x / bounds.width) * CGFloat(cols)), Int((p.y / bounds.height) * CGFloat(rows)))
    }
    
    func getPointStateAndToggle(p: CGPoint)->CellState{
        let x = getCell(p).0
        let y = getCell(p).1
        let vc = ViewController()
        grid[y][x] = vc.toggle(grid[y][x])
        print("\(grid[y][x])")
        return grid[y][x]
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.locationInView(self)
            let x = getCell(location).0
            let y = getCell(location).1
            getPointStateAndToggle(location)
            cell = (x,y)
            let rect = CGRectMake(CGFloat(x)*cellWidth, CGFloat(y)*cellHeight, cellWidth, cellHeight)
            setNeedsDisplayInRect(rect)
            
            
        }
    }
}
