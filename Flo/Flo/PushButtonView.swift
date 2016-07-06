//
//  PushButtonView.swift
//  Flo
//
//  Created by Michael Zhou on 7/5/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

  @IBDesignable

class PushButtonView: UIButton {
  
    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    @IBInspectable var isAddButton: Bool = true
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //red circle draw
        let path = UIBezierPath(ovalInRect: rect)//path with UIBezierPath
        fillColor.setFill()
        path.fill()
        
        //set up width and height variables
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        //create path
        let plusPath = UIBezierPath()
        
        //set path's line width to height of stroke
        plusPath.lineWidth = plusHeight
        
        //move initial point of path to start of horizontal stroke
        plusPath.moveToPoint(CGPoint(x:bounds.width/2 - plusWidth/2 + 0.5, y:bounds.height/2 + 0.5))
        
        //add point to path ad the end of the stroke
        plusPath.addLineToPoint(CGPoint(x:bounds.width/2 + plusWidth/2 + 0.5, y: bounds.height/2 + 0.5))
        
        
        if isAddButton{
            //move initial point of path to start of vertical stroke
            plusPath.moveToPoint(CGPoint(x:bounds.width/2 + 0.5, y:bounds.height/2 - plusWidth/2 + 0.5))
        
            //add point to path ad the end of the stroke
            plusPath.addLineToPoint(CGPoint(x:bounds.width/2 + 0.5, y: bounds.height/2 + plusWidth/2 + 0.5))
        }
        
        //set stroke color
        UIColor.whiteColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
    }
    
    
    

}
