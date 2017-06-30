//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
str = "Hello, Swift"
let constStr = "Hello, world"

var nextYear: Int
var bodyTemp: Float
var hasPet: Bool
var arrayOfInts: [Int]
var dictionaryOfCapital: Dictionary<String,String>
var winningLotteryNumbers: Set<Int>

var countingUp = ["one", "two"]
let nameByParkingSpace = [13: "Alice", 27: "Bob"]
let secondElement = countingUp[1]
countingUp.count
countingUp.append("three")
if let space13Assignee = nameByParkingSpace[13] {
    print("Key 13 is assigned in the dictionary!")
}
let space42Assignee: String? = nameByParkingSpace[42]
for (space, name) in nameByParkingSpace {
    let permit = "Space \(space): \(name)"
    print(permit)
}

let emptyString = String()
let emptyArrayOfInts = [Int]()
let emptySetOfFloats = Set<Float>()
emptyString.isEmpty

let defaultNumber = Int()
let defaultBool = Bool()

let availableRooms = Set([205, 411, 412])
let defaultFloat = Float()
let floatFromLiteral = Float(3.14)

var anOptionalFloat: Float?
var anOptionalArrayOfStirngs: [String]?
var anOptionalArrayOfOptionalStrings: [String?]?

var reading1: Float? = 9.8
var reading2: Float? = 9.2
var reading3: Float?
reading3 = 9.7

if let r1 = reading1, let r2 = reading2, let r3 = reading3 {
    let avgReading = (r1 + r2 + r3) / 3
} else {
    let errorString = "Instrument reported a reading that was nil"
}

for string in countingUp {
    // 'string'사용
}
for (i, string) in countingUp.enumerated() {
    print((i, string))
}

enum PieType {
    case Apple
    case Cherry
    case Pecan
}
let favoritePie = PieType.Apple
let name: String
switch favoritePie {
case .Apple:
    name = "Apple"
case .Cherry:
    name = "Cherry"
case .Pecan:
    name = "Pecan"
}

enum PieType2: Int {
    case Apple = 0
    case Cherry
    case Pecan
}
let pieRawValue = PieType2.Cherry.rawValue
if let pieType = PieType2(rawValue: pieRawValue) {
    
}
