//
//  GridProtocol.swift
//  MikeZhouTest
//
//  Created by Michael Zhou on 7/19/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation

protocol GridProtocol {
    var rows: Int{get set}
    var cols: Int{get set}
    init(rows: Int, cols: Int)
}

class MyClass: GridProtocol{
    private static var _sharedInstance = MyClass(rows: 10, cols: 10)
    static var sharedInstance = MyClass{
            return _sharedInstance
    }
    var rows: Int{
        didSet{
            "Rows"
        }
    }
    var cols: Int{
        didSet{
            "Cols"
        }
    }
}

