//: Playground - noun: a place where people can play

import UIKit


var monthdays = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

func isLeap(year: Int) -> Bool{
    return year%400==0 ? true : year%100==0 ? false : year%4==0 ? true : false
}

func julianDate(year: Int, month: Int, day: Int) -> Int{//get leap year condition
    //let yeardays =  (1900..<year).reduce(0, combine: {($1-1900) * (isLeap($1) ? 366 : 365)})
   // let months = monthdays.reduce(0, combine: +)
    //return yeardays + day
    return (1900..<year).reduce(0, combine: {(year-1900) * (selfConfigurationsViewController.isLeap($1) ? 366 : 365)})
}

//Inspired by Nathan Guerin's section

isLeap(1960)
isLeap(1900)
isLeap(2000)
isLeap(1100)


julianDate(1904, month: 1, day: 28)
