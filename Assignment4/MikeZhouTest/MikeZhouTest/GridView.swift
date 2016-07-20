//
//  GridView.swift
//  MikeZhouTest
//
//  Created by Michael Zhou on 7/19/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class GridView: UIView {

    let π: CGFloat = CGFloat(M_PI)
    
    
    var cellWidth: CGFloat{
        get{
            return bounds.width / CGFloat(gridClass.cols)
        }
    }
    var cellHeight: CGFloat{
        get{
            return bounds.height / CGFloat(gridClass.rows)
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
    }
    
    func drawThem(row: Int, col: Int){
        
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


}
