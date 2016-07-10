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
    }
 

}
