//
//  BackgroundView.swift
//  Flo
//
//  Created by Michael Zhou on 7/10/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

@IBDesignable

class BackgroundView: UIView {

    
    @IBInspectable var lightColor: UIColor = UIColor.orangeColor()
    @IBInspectable var darkColor: UIColor = UIColor.yellowColor()
    @IBInspectable var patternSize: CGFloat = 200
    

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
       // CGContextSetFillColor(context, darkColor.CGColor)
        //**************************************************************
        CGContextSetFillColor(context, darkColor.CGColor)//replace?
        CGContextFillRect(context, rect)
        
        let drawSize = CGSize(width: patternSize, height: patternSize)//square size
        
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        _ = UIGraphicsGetCurrentContext()
        
        darkColor.setFill()
        CGContextFillRect(context, CGRectMake(0, 0, drawSize.width, drawSize.height)) //UIGraphicsBeginImageContent
        
        let trianglePath = UIBezierPath()
        
        trianglePath.moveToPoint(CGPoint(x:drawSize.width/2,
                                            y:0))//bottom center
        trianglePath.addLineToPoint(CGPoint(x:0,
                                            y:drawSize.height/2))//center left
        trianglePath.addLineToPoint(CGPoint(x:drawSize.width,
                                            y:drawSize.height/2))//center right
        trianglePath.moveToPoint(CGPoint(x: 0,
                                        y: drawSize.height/2))//center left
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width/2,
            y: drawSize.height))//center top
        trianglePath.addLineToPoint(CGPoint(x: 0,
            y: drawSize.height))//top left
        trianglePath.moveToPoint(CGPoint(x: drawSize.width,
            y: drawSize.height/2))//center right
        trianglePath.addLineToPoint(CGPoint(x:drawSize.width/2,
            y:drawSize.height))//center top
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width,
            y: drawSize.height))//top right
        
        lightColor.setFill()
        trianglePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()//extract UIImage current context
        UIGraphicsEndImageContext()
        
        //draw as repeated pattern
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)
        
        
    }
 

}
