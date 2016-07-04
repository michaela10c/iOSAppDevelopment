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

let tr = "This is \(str) of strs "

var aFloat : Float

var shoppingList: NSMutableArray = ["catfish", "water", "tulips", "blue paint"] //Next Step Mutable in CLASS
var copyList = shoppingList

shoppingList.addObject(47)

copyList

var occupation: Dictionary<String,String> = [
    "malcom": "captain",
    "kalyee": "mechanic"
]

occupation["jayne"] = "Public Relations"

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

var optionalN:Int? = 24 //YOU handle this stuff
var implicitOptionalN:Int! = 12//Don't worry, I got you covered (BE CAREFUL!!!)

if let n = optionalN{
 let doubleN = doubler(n) //POUVOIR vs DEVOIR
}

doubler(implicitOptionalN)


let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"//nil is defaulted to fullName

let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
var type = ""
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            type = kind
        }
    }
}
print(largest)
print(type)

var n = 2
while n < 100 {
    n = n * 2
}
print(n)

var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)

func special(name: String, day: String) -> String{
    return "Hello \(name)! Today is \(day)"
}
special("Tom", day:"Friday")

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int, avg: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    var avg = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
        
        avg = sum/(scores.count)
    }
    
    return (min, max, sum, avg)
}

let statistics = calculateStatistics([5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.3)

//func sumOf(numbers: Int...) - array 
//(numbers: Int..) - BAD!

//functions CAN be nested!

//var increment = makeIncremeter()
// increment(8)

//return methodName

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]

hasAnyMatches(numbers, condition: lessThanTen)

let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

let sortedNumbers = numbers.sort { $0 > $1 }//greatest to least
print(sortedNumbers)

//?? - default
//? - missing value
// \(value) - String/parsed value
//let - const
//var
//for s in c(an array)
//init..<total

//func method(name: String, day: String) -> String{
//  return "Hello \(name), today is \(day)."
//}
//greet("Bob", day: "Tuesday")
//.. - exclusive (i<=n<t)
//... - inclusive
/*
 func makeIncrementer() -> ((Int) -> Int) {
 func addOne(number: Int) -> Int {
 return 1 + number
 }
 return addOne
 }
 var increment = makeIncrementer()
 increment(7)
 */
//var.simpleDescription

//let mappedNumbers = numbers.map({ number in 3 * number })
//print(mappedNumbers)

//self.name = name - this.name = name
//override func - a func mutated

//Arrays:
//var array = [Int]() - empty
//var defaultArray = [Int](count: 5, repeatedVal)
//Functions nested - OK!
//array.append(n) - add value to array
//array[n]
//array.reverse()
//array.removeAtIndex(n)
//array.first or array.last
//var defaultValueArray = [Int](count: 5, repeatedValue: 0)


//protocol -?
//extension

//super.init - override func

/*var method{
 get{
    return...
 }
 set{
 n = ....
 }

*/

//switch self{ case .Case}
//

protocol P{
    var getset: Int {get set}
    //var setter: Int {set} !!!!That is a NO NO!!!!!!!
}

//Methods outside of the protocol type - NOT declared in protocol

enum PrinterError: ErrorType {
    case OutOfPaper
    case NoToner
    case OnFire
}

func sendToPrinter(printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.NoToner
    }
    return "Job sent"
}

do {
    let printerResponse = try sendToPrinter("Never Has Toner")
    print(printerResponse)
} catch {
    print(error)
}

do {
    let printerResponse = try sendToPrinter("Gutenberg")
    print(printerResponse)
} catch PrinterError.OnFire {
    print("I'll just put this over here, with the rest of the fire.")
    throw PrinterError.OnFire
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}

//try?
//defer - run code regardless of error, before return; cleanup & setup??? Like else?

var hasYeux = false
let lesParts = ["bouche", "nez", "oreilles"]
func sort(part: String) -> Bool
{
    hasYeux = true
    defer{
    hasYeux = false
    }
    
    let result = lesParts.contains(part)
    return result;
}
sort("bouche")
func anyCommonElements <T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs: T, _ rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
anyCommonElements([1, 2, 3], [2,5,4])

typealias existingType = UInt64
var maxAmplitude = existingType.max //equal to the max of the type

let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)//Does NOT have to be an Int - OPTIONAL!!!!
// convertedNumber is inferred to be of type "Int?", or "OPTIONAL Int"

//if let actualNumber = Int(possibleNumber) {here} else {absent}

/*let real = -1
assert(real>=0, "Real numbers are always greater than 0") assertion - une erreur
 */

    
    var anArray:[[Int]] = [[1,0,0], [0,1,0], [0,0,1]]
    
    
    func dump() {
        for (i,row) in anArray.enumerate() {
            for (j,cell) in row.enumerate() {
                print("m[\(i),\(j)] = \(cell)")
            }
        }
    }
    


dump()



