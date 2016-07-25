//: Playground - noun: a place where people can play

import UIKit


var monthDaysInYear = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

func isLeap(year: Int) -> Bool{
    return year%400==0 ? true : year%100==0 ? false : year%4==0 ? true : false
}

func julianDate(year: Int, month: Int, day: Int) -> Int{//get leap year condition
    let yearDays = (1900..<year).map({(number:Int)->Int in return isLeap(number) ? 366 : 365}).reduce(0, combine: +)
    let monthDays = monthDaysInYear[0..<month].reduce(0, combine: +)
    return yearDays + monthDays + day
}

//Inspired by Nathan Guerin's section

isLeap(1960)
isLeap(1900)
isLeap(2000)


julianDate(1960, month: 9, day: 28)
julianDate(1900, month: 1, day: 1)
julianDate(2000, month: 12, day: 31)
julianDate(2001, month: 1, day: 1) - julianDate(2000, month: 1, day: 1)
