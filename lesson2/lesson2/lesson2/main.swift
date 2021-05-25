//
//  main.swift
//  lesson2
//
//  Created by mac on 25.05.2021.
//

import Foundation

func isEven(inNumber number: Int, _ multiple: Int = 2) -> Bool {
    return number % multiple == 0
}

/* ======================================================================================= */
// Задание 1
// Четное число или нет
print("====== Задание 1 ======")

print("Число 2 кратно 2? " + (isEven(inNumber: 2) ? "да" : "нет"))
print("Число 15 кратно 2? " + (isEven(inNumber: 15) ? "да" : "нет"))

/* ======================================================================================= */
// Задание 2
print("====== Задание 2 ======")

print("Число 2 кратно 3? " + (isEven(inNumber: 2, 3) ? "да" : "нет"))
print("Число 15 кратно 3? " + (isEven(inNumber: 15, 3) ? "да" : "нет"))

/* ======================================================================================= */
// Задание 3
var testArray = [Int]()

for i in 1...100 {
    testArray.append(i)
}
//print(testArray)

/* ======================================================================================= */
// задание 4
//[1, 5, 7, 11, 13, 17, 19, 23, 25, 29, 31, 35, 37, 41, 43, 47, 49, 53, 55, 59, 61, 65, 67, 71, 73, 77, 79, 83, 85, 89, 91, 95, 97]

/* Простой вариант
testArray.removeAll{ value in
    isEven(inNumber: value) || isEven(inNumber: value, 3)
}
*/

for (index, value) in testArray.enumerated().reversed() {
    if (isEven(inNumber: value) || isEven(inNumber: value, 3)) {
        testArray.remove(at: index)
    }
}

print("====== Задание 4 ======")
print(testArray)

/* ======================================================================================= */
// Задание 5

var fiboNumbers = [Double]()

func generateFiboNumber(incomingArray inArray: inout [Double]) -> () {
    if (inArray.count >= 100) {
        return
    }

    /*
    if (inArray.count < 2) {
        inArray = [Double]()
        inArray.append(0)
        inArray.append(1)
    } else {
        let prevNumber = inArray[inArray.count - 1]
        let prev2Number = inArray[inArray.count - 2]
        let nextNumber = prevNumber + prev2Number

        inArray.append(nextNumber)
    }
     */
    switch inArray.count {
    case _ where inArray.count < 2:
        inArray = [Double]()
        inArray.append(0)
        inArray.append(1)
    default:
        let prevNumber = inArray[inArray.count - 1]
        let prev2Number = inArray[inArray.count - 2]
        let nextNumber = prevNumber + prev2Number

        inArray.append(nextNumber)
    }
    generateFiboNumber(incomingArray: &inArray)
}

generateFiboNumber(incomingArray: &fiboNumbers)

print("====== Задание 5 ======")
print(fiboNumbers)

/* ======================================================================================= */
// Задание 6

var intDict = [Int]()
let p: Int = 2
let n: Int = 100

for i in 2...n {
    intDict.append(i)
}

func calculateItems(startIndex index: Int = 2, _ inDist: inout [Int]) -> () {
    var nextIndex: Int? = nil

    for (key, value) in inDist.enumerated().reversed() {
        if (key < index) {
            continue
        }

        if (value % index == 0) {
            inDist.remove(at: key)
        }
    }

    nextIndex = inDist.first(where: { $0 > index })

    if (nextIndex! < inDist.max()!) {
        calculateItems(startIndex: nextIndex!, &inDist)
    }
}

calculateItems(&intDict)
print("====== Задание 6 ======")
print(intDict)
