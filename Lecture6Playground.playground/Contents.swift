//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//
//  ExampleProtocol.swift
//  Lecture6
//
//  Created by Michael Zhou on 7/11/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation

protocol ExampleProtocol {
    var rows: UInt {get set}
    var cols: UInt {get set}
    func step() -> [[Bool]]
    
    
}

protocol ExampleDelegateProtocol {
    func example(example: Example, didUpdateRows:UInt)
}

class Example : ExampleProtocol{
    var rows: UInt = 0{
        didSet{
            if let delegate = delegate {
                delegate.example(self, didUpdateRows: self.rows)
            }
        }
    }
    var cols: UInt = 0
    var delegate: ExampleDelegateProtocol?
    func step() -> [[Bool]] {
        return [[false]]
    }
    
}

class ExampleDelegate: ExampleDelegateProtocol{
    func example(example: Example, didUpdateRows: UInt) {
        print("Nothing")
    }
}

var ex = Example()
var exd = ExampleDelegate()

//didSet
ex.delegate = exd
ex.rows = 10

