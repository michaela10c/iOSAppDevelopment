//: Playground - noun: a place where people can play

import Foundation


//Read Evaluate Print Loop

let immutableString = "hello, playground"
var str = "Hello, playground"

str = "another str"

var myInt = 42
let myConstant = 50.0/100

let implicitDouble = 70.0// implied
let explicitDouble: Double = 70 // declared

let label = "the width is "
let width = 94
let widthLabel = label + String(width)
String(94)
let apples = 3
let oranges = 5
var appleSummary = "I have \(apples) apples."
appleSummary = "I have \(oranges) oranges." // \ - parse to string

var aFloat : Float

var shoppingList: Array<Any> = ["catfish", "water", "tulips", "blue paint"]
shoppingList.append("toothpaste")
shoppingList.append("James M. Howard")
shoppingList.append(99)
shoppingList.last

var occupation: Dictionary<String,String> = [
    "malcom": "captain",
    "kalyee": "mechanic"
]

occupation["Jayne"] = "Public Relations"

occupation
