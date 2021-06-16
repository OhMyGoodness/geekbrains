//
// Лазин Данил Николаевич 09/06/2021
//  main.swift
//  lesson6

import Foundation

enum MyThrows: Error {
    case division_by_zero
    case unknown_car
}

enum CarTypes{
    case bmw
    case tesla
    case lada
    case ferrari
}

var cars = [CarTypes.bmw: 200, CarTypes.tesla: 300, CarTypes.lada: 50]

class MyMath {
    static func divide(_ num: Int, _ divider: Int) throws -> Float? {
        if (divider == 0) {
            throw MyThrows.division_by_zero
        }

        return Float(num) / Float(divider)
    }

    static func getCarSpeed(_ type: CarTypes) throws -> Int{
        guard let carSpeed = cars[type] else{
            throw MyThrows.unknown_car
        }

        return carSpeed
    }

    static func setNewCarSpeed(_ type: CarTypes, _ addSpeed: Int) throws -> Int {
        let selectedCarSpeed: Int? = try getCarSpeed(type)

        cars[type] = selectedCarSpeed! + addSpeed

        return cars[type]!
    }
}

do {
    let result1: Float? = try MyMath.divide(100, 2)

    print("Result 1 = \(result1!)")

    let result2: Float? = try MyMath.divide(100, 0)
    print("Result 2 = \(result2!)")
} catch MyThrows.division_by_zero {
    print("Деление на ноль запрещено")
}

var carSpeed: Int?
do{
    carSpeed = try MyMath.getCarSpeed(.tesla)
}
catch MyThrows.unknown_car{
    print("Машина не найдена")
}

do{
    // внутри блоков лучше так не делать, но в рамках ДЗ сделал ;(
    let newCarSpeed = try MyMath.setNewCarSpeed(.tesla, 10)

    print("Новая скорость машины равна = \(newCarSpeed)")
}
catch MyThrows.unknown_car{
    print("Невозможно изменить скорость авто, Машина не найдена")
}

//////////////
do{
    // внутри блоков лучше так не делать, но в рамках ДЗ сделал ;(
    let newCarSpeed = try MyMath.setNewCarSpeed(.ferrari, 10)

    print("Новая скорость машины равна = \(newCarSpeed)")
}
catch MyThrows.unknown_car{
    print("Невозможно изменить скорость авто, Машина не найдена")
}