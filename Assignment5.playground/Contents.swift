//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var monthdays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
var year = 12

func isLeap(year: Int) -> Bool{
    return year%400==0 ? true : year%100==0 ? false : year%4==0 ? true : false
}

func julianDate(year: Int, month: Int, day: Int) -> Int{
    //(isLeap(year) ? 28 : 29)
}

isLeap(1960)
isLeap(1900)
isLeap(2000)

julianDate(1900, month: 9, day: 28)