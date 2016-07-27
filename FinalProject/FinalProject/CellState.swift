//
//  CellState.swift
//  FinalProject
//
//  Created by Michael Zhou on 7/25/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation

enum CellState{
    case Empty, Died, Born, Alive
    
    func isLiving() -> Bool {
        switch self {
        case .Born, .Alive: return true
        default: return false
        }
    }
}