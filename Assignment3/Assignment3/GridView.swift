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
    var rowHeight: CGFloat{
        get{
            return bounds.height / CGFloat(rows)
        }
    }
    
    

    
    var grid = Array(count:20, repeatedValue:Array(count:20, repeatedValue: CellState.Empty))
   
   
   
    
    override func drawRect(rect: CGRect) {
        let line = UIBezierPath()//grid lines
       
        let h: CGFloat = 1.5
        let w: CGFloat = min(bounds.width, bounds.height)
        
        line.lineWidth = h
        
        
        for x in 0..<rows+1{
            for y in 0..<cols+1{
                line.moveToPoint(CGPoint(x: CGFloat(x) * (w / CGFloat(rows)), y: frame.height - h))
                line.addLineToPoint(CGPoint(x: CGFloat(x) * (w / CGFloat(rows)), y: h))
                UIColor.brownColor().setStroke()
                line.stroke()
                
                line.moveToPoint(CGPoint(x: frame.width - w, y: CGFloat(y) * (w / CGFloat(cols))))
                line.addLineToPoint(CGPoint(x: w, y: CGFloat(y) * (w / CGFloat(cols))))
                UIColor.brownColor().setStroke()
                line.stroke()
                
                 let cPath = UIBezierPath(arcCenter: findCenter(x, col: y),
                                          radius: w / CGFloat(rows) / 2,
                                          startAngle: 0, endAngle: 2 * π,
                                            clockwise: false)
               
                cPath.lineWidth = h
                fillOnRun(CellState.Empty)
                cPath.stroke()
                cPath.fill()
                
               
                
            }
        }
        
    }
    
    
    
    
    func getPointState(p: CGPoint) -> CellState{
        let x = Int((p.x / bounds.width) * CGFloat(cols))
        let y = Int((p.y / bounds.height) * CGFloat(rows))
        //0,0 deficient?
        print("\(x),\(y)")
        
        let vc = ViewController()
        grid[x][y] = vc.toggle(grid[x][y])
        
        return grid[x][y]
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch!{
            let p  = getPointState(touch.locationInView(self))
            print("\(p)")
            fillFromTouch(p)
        }
    }
    
    
    
   
    
    //1. plot the points
    //2. draw in the lines
    //3. find center - center formula
    //4. Find center
    
    
    
    func findCenter (row: Int, col: Int) -> CGPoint{
        let x1 = CGFloat(col) * cellWidth
        let y1 = CGFloat(row) * rowHeight
        let x2 = x1 + cellWidth
        let y2 = y1 + rowHeight
       
        func cellRadius () -> CGFloat{
            return min(cellWidth/2.0, rowHeight/2.0)
        }
        
        return CGPoint(x: (x1+x2)/2, y: (y1+y2)/2)
        
    }
    

    func fillFromTouch(state: CellState){//like toggle()
        switch state{
        case .Born, .Living:
            emptyColor.setStroke()
            emptyColor.setFill()
        default:
            livingColor.setStroke()
            livingColor.setFill()
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
    
    
    
}




