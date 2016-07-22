//: Playground - noun: a place where people can play

import UIKit


var monthdays = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
typealias date = (year: Int, month: Int, day: Int)

func isLeap(year: Int) -> Bool{
    return year%400==0 ? true : year%100==0 ? false : year%4==0 ? true : false
}

func julianDate(year: Int, month: Int, day: Int) -> Int{
    return monthdays.reduce(year, combine: +)
    //let days = (1...month).map({monthdays[$0]})
    //return days.reduce(0, combine: { $0 + $1 })
    //(1...month).map({isLeap(year) && $0 == 2 ? 29 : 28})
    
}
//Inspired by Nathan Guerin's section

isLeap(1960)
isLeap(1900)
isLeap(2000)
isLeap(1100)



julianDate(1900, month: 9, day: 28)