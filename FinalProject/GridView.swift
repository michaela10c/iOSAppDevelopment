//
//  GridView.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/26/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import UIKit

class GridView: UIView {

    var rows: Int = StandardEngine.sharedUpdates.rows
    var cols: Int = StandardEngine.sharedUpdates.cols
    var grid = StandardEngine.sharedUpdates.grid
    
    var position = Position(0,0)
    
    var cellWidth: CGFloat { get{return bounds.width/CGFloat(cols)}}
    var cellHeight: CGFloat { get{return bounds.width/CGFloat(rows)}}
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        print("\(rows), \(cols)\n\(grid)")
        if rect.width == cellWidth || rect.height == cellHeight{drawGrid(position)}
    }
    
    func drawGrid(pos: Position){
        
    }
 

}
