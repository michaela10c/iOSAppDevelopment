//
//  Engine.swift
//  Assignment2
//
//  Created by Michael Zhou on 2016/6/30.
//  Copyright © 2016年 Michael Zhou. All rights reserved.
//

import Foundation

func step(input:Array<Array<Bool>>) -> Array<Array<Bool>>{//loopover
    var nextStep: Array<Array<Bool>> = Array(count:input.count, repeatedValue:
        Array(count:input.count, repeatedValue:Bool()))
    let l = Problem2ViewController()
    a = 0
    d = 0
    live.removeAll()
    for j in 0..<input.count{
        for k in 0..<input.count{
            nextStep[j][k] = l.numNeighbors(j, k: k)
        }
    }
    
    return nextStep
}

func neighbors(j: Int, k: Int) -> Array<Point>{
    var coord: [Point] = []
   //  let l = Problem2ViewController()
    for j in (-1...1){
        for k in (-1...1){
            coord.append(Point(j: j+j, k: k+k))
        }
    }
   // l.appendArrays()
    return coord
    
}
func step2(input: Array<Array<Bool>>)->Array<Array<Bool>>{
    a = 0
    d = 0
    var ns = Array(count:input.count, repeatedValue: Array(count: input.count, repeatedValue:Bool()))
    for j in 0..<input.count{
        for k in 0..<input.count{
            neighbors(j, k: k)
        }
    }
    ns = step(ns)
    return ns
}