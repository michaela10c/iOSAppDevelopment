//
//  StandardEngine2.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/21/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation

class StandardEngine: EngineProtocol{
    private static var _sharedGridSize = StandardEngine(rows: 4, cols: 4)
    static var sharedGridSize: EngineProtocol{//is this how I call this singleton?
        get{
            return _sharedGridSize
        }
    }
    
    
    
    private static var _rows: Int
    private var rows: Int{
        get{
            
        }
    }
}