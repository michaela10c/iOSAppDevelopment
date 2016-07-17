//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//
//  GridProtocol.swift
//  Assignment4
//
//  Created by Michael Zhou on 7/14/16.
//  Copyright © 2016 Michael Zhou. All rights reserved.
//

import Foundation

protocol Shape{
    init(width: Int, height: Int)
    var width: Int {get}
    var height: Int {get}
    func area() -> Double
}

struct Rectangle: Shape{
    init(width: Int, height: Int){
        self.width = width
        self.height = height
    }
    var width: Int
    var height: Int
    func area() -> Double{
        return Double(width * height)
    }
}

struct Circle : Shape{
    init(width: Int, height: Int){
        self.width = width
        self.height = height
    }
    var width: Int
    var height: Int
    func area() -> Double{
        return M_PI * (Double(width) * 0.5) * (0.5 * Double(width))
    }
    
    var radius: Double{
        return (0.5 * Double(width))
    }
}

var shape : Shape
shape = Rectangle(width: 3, height: 4)
print("Area is \(shape.area)")
shape = Circle(width: 10, height: 10)
print("Area is \(shape.area)")