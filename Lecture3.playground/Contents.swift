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

var shoppingList: NSMutableArray = ["catfish", "water", "tulips", "blue paint"] //Next Step Mutable in CLASS
var copyList = shoppingList

shoppingList.addObject(47)

copyList
var occupation: Dictionary<String,String> = [
    "malcom": "captain",
    "kalyee": "mechanic"
]

occupation["Jayne"] = "Public Relations"

/////
var occupationNames = occupation.map {$0.0}.map {$0; "blah"} //Coolest way!!!
occupationNames


var r = 50...100
var g = r.generate()
g.next()
g.next()

var g1 = [11,21,31,41,51].generate()

var tuple1 = (1,2)
tuple1.0
tuple1.1


var tuple2 = (first:"van", last: "Simmons")
tuple2.first
tuple2.last

for(l,v) in occupation {
    print("\(l),\(v)")
}

func doubler(x:Int) -> Int{
    return x*2
}

func doubleDoubler(x:Double) -> Double {
    return x*2
}

doubler(4)
doubleDoubler(3)

func progression(v:Int,f: Int->Int) -> Int{
    return f(v)
}

progression(4,f:doubler)


//!!!!!!
var tf = false
tf = true

var arrArr:Array<Dictionary<Int,Bool>> = [[1:true]]

var closure = { (x:Int) -> Int in
    return x*2
}

closure(6)

progression(6,f:closure)

progression(6, f: {(x:Int) -> Int in
    return x*2
})
