//
//  GridProtocol.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation

protocol GridProtocol{
   
    init(rows: Int, cols: Int)
    var rows: Int {get}
    var cols: Int {get}
    var grid: [[CellState]] {get set}
    func neighbors(row: Int, col: Int) -> [(Int, Int)]
    subscript(row: Int, col: Int) -> CellState { get set }
}

