//
//  Engine.swift
//  Assignment2
//
//  Created by Michael Zhou on 2016/6/30.
//  Copyright © 2016年 Michael Zhou. All rights reserved.
//

import Foundation

func step(input:Array<Array<Bool>>) -> Array<Array<Bool>>{//loopover
    let nextStep: Array<Array<Bool>> = Array(count:input.count, repeatedValue:
        Array(count:input.count, repeatedValue:Bool()))
    let l = Problem2ViewController()
    a = 0
    d = 0
    for j in 0..<input.count{
        for k in 0..<input.count{
            l.numNeighbors(j, k: k)
        }
    }
    
    return nextStep
}


