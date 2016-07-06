//
//  GridView.swift
//  Assignment3
//
//  Created by Michael Zhou on 7/6/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

@IBDesignable

class GridView: UIView {

    @IBInspectable var rows: Int = 20
    @IBInspectable var cols: Int = 20
    
    @IBInspectable var emptyColor: UIColor = UIColor.whiteColor()
    @IBInspectable var livingColor: UIColor = UIColor.yellowColor()
    @IBInspectable var bornColor: UIColor = UIColor.greenColor()
    @IBInspectable var diedColor: UIColor = UIColor.redColor()
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
