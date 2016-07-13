//
//  GridView.swift
//  Assignment3
//
//  Created by Michael Zhou on 7/6/16.
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
    
    var grid = Array(count:20, repeatedValue:Array(count:20, repeatedValue: CellState.Empty))
   
    var initialize = true
    
    override func drawRect(rect: CGRect) {
        if initialize{
            for x in 0..<rows{//
                for y in 0..<cols{//
                    fillPoint(x, y: y)
                }
            }
            
        }
        else {
          //fillPoint(<#T##x: Int##Int#>, y: <#T##Int#>)
        }
        
        initialize = false
   
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
        let gridStatus = grid[x][y]
        fillFromTouch(gridStatus)
        cPath.stroke()
        cPath.fill()
    }
    
    
    
    func getPoint(p: CGPoint) -> (Int,Int) {
        return (Int((p.x / bounds.width) * CGFloat(cols)), Int((p.y / bounds.height) * CGFloat(rows)))
    }
    
    func redraw(x: Int, y: Int){
         fillPoint(x, y: y)
    }
    
    func getPointState(p: CGPoint) -> CellState{
        let x = getPoint(p).0
        let y = getPoint(p).1
        print("\(x),\(y)")
        
        let vc = ViewController()
        grid[x][y] = vc.toggle(grid[x][y])//toggle
        print("\(grid[x][y])")
        return grid[x][y]
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first{
            getPointState(touch.locationInView(self))//toggle
            let x = getPoint(touch.locationInView(self)).0//get point
            let y = getPoint(touch.locationInView(self)).1
            let rect = CGRectMake(CGFloat(x)*cellWidth+1.5, CGFloat(y)*cellHeight+1/5, cellWidth, cellHeight)
            setNeedsDisplayInRect(rect)
            //getPointState(touch.locationInView(self))
        }
    }
    //1. plot the points
    //2. draw in the lines
    //3. find center - center formula
    //4. Find center
    
    
    
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
    

    func fillFromTouch(state: CellState){//like toggle()
        switch state{
        case .Born, .Living:
            livingColor.setStroke()
            livingColor.setFill()
        default:
            emptyColor.setStroke()
            emptyColor.setFill()
        }
    }
    
    func fillOnRun(state: CellState){
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
    
    
   /* func neighbors (x: Int, y: Int) -> CellState{
        var liveCells = 0
        
        switch liveCells{
        case 0:
            grid[x][y] = CellState.Died
        //case 1:
            grid[x][y] = CellState.Died
        case 2:
            if grid[x][y] == CellState.Born || grid[x][y] == CellState.Empty{
                grid[x][y] = CellState.Living
            } else {
                grid[x][y] = CellState.Empty }
        case 3:
            grid[x][y] = CellState.Living
            
        }
        
            return grid[x][y]
    
        }*/
    
    
    
    }


    





