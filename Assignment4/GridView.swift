//
//  GridView.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/16/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    let gridClass = Grid(rows: StandardEngine.sharedGridSize.grid.rows, cols: StandardEngine.sharedGridSize.grid.cols)
    var rows: Int = StandardEngine.sharedGridSize.grid.rows
    var cols: Int = StandardEngine.sharedGridSize.grid.cols
    
    var grid = StandardEngine.sharedGridSize.grid{
        didSet{
            rows = grid.rows
            cols = grid.cols
            setNeedsDisplay()
            print("I set my grid!")
        }
    }
    
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
            fillPoint(cell.1, y: cell.0)
        } else {
            for x in 0..<rows{
                for y in 0..<cols{
                    fillPoint(x, y: y)
                    print("\(x), \(y)")
                }
            }
        }
    }
 
    func fillPoint(x: Int, y: Int){
        let width: CGFloat = min(bounds.width, bounds.height)
        let cPath = UIBezierPath(arcCenter: findCenter(x, col: y),
                                 radius: (width / CGFloat(rows) / 2)-1,
                                 startAngle: 0, endAngle: 2 * π,
                                 clockwise: false)
        cPath.lineWidth = 1.5
        getFill(grid[y,x])

        cPath.stroke()
        cPath.fill()
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            let location = touch.locationInView(self)
            let col = getCell(location).0//getCell -> (col, row)
            let row = getCell(location).1
            grid[row,col] = getPointStateAndToggle(location)
            cell = (row,col)
            print("\(cell)")
            let rect = CGRectMake(CGFloat(col)*cellWidth, CGFloat(row)*cellHeight, cellWidth, cellHeight)
            
            setNeedsDisplayInRect(rect)
        }
    }
    
    func getPointStateAndToggle(p: CGPoint)->CellState{
        let x = getCell(p).0
        let y = getCell(p).1
        grid[x,y] = gridClass.toggle(grid[x,y])
        print("\(grid[x,y])")
        return grid[x,y]
    }
    
    @IBAction func change(sender: AnyObject) {
        print("\(grid)")
        StandardEngine.sharedGridSize.step()
        setNeedsDisplay()
    }
    
}
