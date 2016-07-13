//
//  MedalView.swift
//  Flo
//
//  Created by Michael Zhou on 7/10/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class MedalView: UIImageView {

    lazy var medalImage:UIImage = self.createMedalImage()//will not run if use does not use the app
    @IBOutlet weak var medalView: MedalView!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func createMedalImage() -> UIImage {
        print("creating Medal Image")
        
        let size = CGSize(width: 120, height: 200)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        
        //Gold colors
        let darkGoldColor = UIColor(red: 0.6, green: 0.5, blue: 0.15, alpha: 1.0)
        let midGoldColor = UIColor(red: 0.86, green: 0.73, blue: 0.3, alpha: 1.0)
        let lightGoldColor = UIColor(red: 1.0, green: 0.98, blue: 0.9, alpha: 1.0)
        
        //Lower Ribbon
        let lowerRibbonPath = UIBezierPath()
        lowerRibbonPath.moveToPoint(CGPointMake(0, 0))
        lowerRibbonPath.addLineToPoint(CGPointMake(40,0))
        lowerRibbonPath.addLineToPoint(CGPointMake(78, 70))
        lowerRibbonPath.addLineToPoint(CGPointMake(38, 70))
        lowerRibbonPath.closePath()
        UIColor.redColor().setFill()
        lowerRibbonPath.fill()
        
        //Clasp
        
        let claspPath = UIBezierPath(roundedRect:
            CGRectMake(36, 62, 43, 20),
                                     cornerRadius: 5)
        claspPath.lineWidth = 5
        darkGoldColor.setStroke()
        claspPath.stroke()
        
        
        let medallionPath = UIBezierPath(ovalInRect:
            CGRect(origin: CGPointMake(8, 72),
                size: CGSizeMake(100, 100)))
        CGContextSaveGState(context)
        medallionPath.addClip()
        let gradient = CGGradientCreateWithColors(
            CGColorSpaceCreateDeviceRGB(),
            [darkGoldColor.CGColor,
                midGoldColor.CGColor,
                lightGoldColor.CGColor],
            [0, 0.51, 1])
        CGContextDrawLinearGradient(context,
                                    gradient,
                                    CGPointMake(40, 40),
                                    CGPointMake(100,162),
                                    CGGradientDrawingOptions(rawValue: 0))
        CGContextRestoreGState(context)//add ribbon back in
        
        //Create a transform
        //Scale it, and translate it right and down
        var transform = CGAffineTransformMakeScale(0.8, 0.8)//scale to 0.8
        transform = CGAffineTransformTranslate(transform, 15, 30)
        
        medallionPath.lineWidth = 2.0
        
        //apply the transform to the path
        medallionPath.applyTransform(transform)
        medallionPath.stroke()
        
        //Upper Ribbon
        
        let upperRibbonPath = UIBezierPath()
        upperRibbonPath.moveToPoint(CGPointMake(68, 0))
        upperRibbonPath.addLineToPoint(CGPointMake(108, 0))
        upperRibbonPath.addLineToPoint(CGPointMake(78, 70))
        upperRibbonPath.addLineToPoint(CGPointMake(38, 70))
        upperRibbonPath.closePath()
        
        UIColor.blueColor().setFill()
        upperRibbonPath.fill()
        
        //Number One
        
        //Must be NSString to be able to use drawInRect()
        let numberOne = "1"
        let numberOneRect = CGRectMake(47, 100, 50, 50)
        let font = UIFont(name: "Academy Engraved LET", size: 60)
        _ = NSMutableParagraphStyle.defaultParagraphStyle()//text style
        let numberOneAttributes = [
            NSFontAttributeName: font!,
            NSForegroundColorAttributeName: darkGoldColor]//attributes array
        numberOne.drawInRect(numberOneRect,
                             withAttributes:numberOneAttributes)//draw
        
        //Add Shadow
        let shadow:UIColor = UIColor.blackColor().colorWithAlphaComponent(0.80)
        let shadowOffset = CGSizeMake(2.0, 2.0)
        let shadowBlurRadius: CGFloat = 5
        
        CGContextSetShadowWithColor(context,
                                    shadowOffset,
                                    shadowBlurRadius,
                                    shadow.CGColor)
        
        
        CGContextBeginTransparencyLayer(context, nil)
        CGContextEndTransparencyLayer(context)
        
        //ALWAYS END OF PLAYGROUND
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
        
    }
    
    func showMedal(show:Bool) {
        if show {
            image = medalImage
        } else {
            image = nil
        }
    }
    
    

}
