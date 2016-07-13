//
//  CounterView.swift
//  Flo
//
//  Created by Michael Zhou on 7/6/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

let NoOfGlasses = 8//Maximum NoOfGlasses
let π: CGFloat = CGFloat(M_PI)//Pi declaration

@IBDesignable class CounterView: UIView {

//**********IMPORTANT!!!!!!!!! UPDATE COUNTER VIEW when counter property updated!!!!!!!!!!!******************************
    @IBInspectable var counter: Int = 5{
        didSet {
            if counter <= NoOfGlasses{
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()

    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let center = CGPoint(x:bounds.width/2, y:bounds.height/2)
        
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        let arcWidth: CGFloat = 76//thickness of arc
        
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        let path = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()//orange
        path.stroke()
        
        
        //POSITIVE difference between 2 angles
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle//2π - start + end
        
        //arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)//split in sections
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle//multiply by actual glasses drunk //CGFloat casting
        
        
        //outer arc
        let outlinePath = UIBezierPath(arcCenter: center,
                                       radius: bounds.width/2 - 2.5,
                                       startAngle: startAngle,
                                       endAngle: outlineEndAngle,
                                       clockwise: true)
        
        //inner arc
        outlinePath.addArcWithCenter(center,
                                     radius: bounds.width/2 - arcWidth + 2.5,
                                     startAngle: outlineEndAngle,
                                     endAngle: startAngle,
                                     clockwise: false)
        
        //close the path
        outlinePath.closePath()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
        
        
        //counter view markers
        
        let context = UIGraphicsGetCurrentContext()
        
        //1. save original state
        CGContextSaveGState(context)
        outlineColor.setFill()
        
        let markerWidth: CGFloat = 5.0
        let markerSize: CGFloat = 10.0
        
        //2. marker rectangle at top left
        let markerPath = UIBezierPath(rect: CGRect(x: -markerWidth/2,
            y: 0, width: markerWidth, height: markerSize))
        
        //3. move top left of context to previous center position
        CGContextTranslateCTM(context, rect.width/2, rect.height/2)
        
        for i in 1...NoOfGlasses{
           //save centered context
            CGContextSaveGState(context)
            
            //5. calculate rotation angle
            let angle = arcLengthPerGlass * CGFloat(i) + startAngle - π/2
            
            //rotate and translate
            CGContextRotateCTM(context, angle)
            CGContextTranslateCTM(context, 0, rect.height/2 - markerSize)
            
            //6. fill marker rectangle
            markerPath.fill()
            
            //7. restore centered context for next rotate
            CGContextRestoreGState(context)
            }
            //8. Restore again in case of more drawing
            CGContextRestoreGState(context)
        }
    
        
    }
 


