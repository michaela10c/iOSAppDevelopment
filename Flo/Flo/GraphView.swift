//
//  GraphView.swift
//  Flo
//
//  Created by Michael Zhou on 7/6/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
    var graphPoints: [Int] = [4,2,6,4,5,8,3]//seven days
    
    
     // gradient properties
    @IBInspectable var startColor: UIColor = UIColor.redColor()
    @IBInspectable var endColor: UIColor = UIColor.greenColor()
    override func drawRect(rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        //background of clipping area setup
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: UIRectCorner.AllCorners,
                                cornerRadii: CGSize(width: 8.0, height: 8.0))
        
        path.addClip()
        
       //current context
        let context = UIGraphicsGetCurrentContext()//get current context
        let colors = [startColor.CGColor, endColor.CGColor]//start to end array
        
        //color space set up 
        let colorSpace = CGColorSpaceCreateDeviceRGB()//RGB
        
        //color stops
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        //create gradient
        let gradient = CGGradientCreateWithColors(colorSpace,
                                                  colors,
                                                  colorLocations)//refer by naming
        
        //draw gradient
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x:0, y:self.bounds.height)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions.init(rawValue: 0))
        
        //x point
        let margin: CGFloat = 20.0
        var columnXPoint = { (column: Int) -> CGFloat in
            //gap between points
            let spacer = (width - margin*2 - 4) /
            CGFloat((self.graphPoints.count - 1))
            var x:CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        //y point
        let topBorder: CGFloat = 60
        let bottomBorder: CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.maxElement()
        var columnYPoint = { (graphPoint: Int) -> CGFloat in
            var y: CGFloat = CGFloat(graphPoint) /
                CGFloat(maxValue!) * graphHeight
            y = graphHeight + topBorder - y
            return y
        }
        
        UIColor.whiteColor().setFill()
        UIColor.whiteColor().setStroke()
        
        var graphPath = UIBezierPath()
        graphPath.moveToPoint(CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        
        for i in 1..<graphPoints.count{
            let next = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLineToPoint(next)
        }
        
        //save state of context
        CGContextSaveGState(context)
        
        //copy of graphPath
        var clippingPath = graphPath.copy() as! UIBezierPath
        
        //add lines to copied path
        clippingPath.addLineToPoint(CGPoint(x: columnXPoint(graphPoints.count - 1),
                                            y: height))
        clippingPath.addLineToPoint(CGPoint(x:columnXPoint(0),y:height))
        clippingPath.closePath()
        
        //add clippingPath to context
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue!)
        startPoint = CGPoint(x: margin, y: highestYPoint)
        endPoint = CGPoint(x: margin, y: self.bounds.height)
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions.init(rawValue: 0))
        CGContextRestoreGState(context)
        
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        for i in 0..<graphPoints.count{
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalInRect: CGRect(origin: point, size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
        //draw 3 horizontal lines on top of them
        var linePath = UIBezierPath()
        
        //top line
        linePath.moveToPoint(CGPoint(x:margin, y:topBorder))
        linePath.addLineToPoint(CGPoint(x:width-margin, y:topBorder))
        
        //center line
        linePath.moveToPoint(CGPoint(x:margin, y:graphHeight/2+topBorder))
        linePath.addLineToPoint(CGPoint(x:width-margin, y:graphHeight/2 + topBorder))
        
        //bottom line
        linePath.moveToPoint(CGPoint(x:margin, y:height-bottomBorder))
        linePath.addLineToPoint(CGPoint(x:width-margin, y:height-bottomBorder))
        
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
        
    }
    

}
