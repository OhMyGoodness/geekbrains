//
//  main.swift
//  lesson5
//
//  Created by Данила Лазин on 04.06.2021.
//
//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем:
//   открыть/закрыть окно, запустить/заглушить двигатель и т.д.
//   (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства,
//   отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.
//

import Foundation

enum MyCustomCargoException: Error {
    case cargo_not_initialized
}

protocol CarProtocol {
    var YearProduction: Int { get set }
    var Model: String { get set }
    var GasVolume: Float { get set }

    var IsWindowOpened: Bool { get set }
    var IsEngineRunned: Bool { get set }

    init(_ yearProd: Int, _ model: String, _ gasVolume: Float)

    func getCurrentGasVolume() -> Float
}

extension CarProtocol {
    mutating func onActionWindowOpen() -> () {
        self.IsWindowOpened = true
        print("Действие: открыть окна")
    }

    mutating func onActionWindowClose() -> () {
        self.IsWindowOpened = false
        print("Действие: закрыть окна")
    }

    mutating func onEngineRun() -> () {
        IsEngineRunned = true
        print("Действие: запустить двигатель")
    }

    mutating func onEngineStop() -> () {
        IsEngineRunned = true
        print("Действие: остановить двигатель")
    }
}

// простите, у меня травма)) перечисления привык в верхнем регистре делать((
enum CargoType {
    case BODY
    case TRUNK
    case GAS
}

struct CargoProperties {
    var CargoMaxVolume: Float = 0.0
    var CargoCurrentVolume: Float = 0
    var CargoType: CargoType

    init(_ maxVol: Float, _ type: CargoType) {
        CargoMaxVolume = maxVol
        CargoType = type
        CargoCurrentVolume = 0
    }
}

protocol CarCargoProtocol {
    var CargoProps: CargoProperties? { get set }

    var CargoMaxVolume: Float { get set }

    var CargoInitialized: Bool { get set }

    func InitializeCargo(_ maxVol: Float, _ type: CargoType)

    mutating func UploadToCargo(_ volume: Float) -> ()

    mutating func UnloadFromCargo(_ volume: Float) -> ()
}

var teslaCar = TeslaTrunkClass.init(2021, "X6", 500.5)
teslaCar.UploadToCargo(10)
teslaCar.InitializeCargo(1000, .TRUNK)
teslaCar.UploadToCargo(100)
teslaCar.onActionWindowOpen()

if (teslaCar is CarNitroExtension)
{
    (teslaCar as! CarNitroExtension).onNitro()
}

print(teslaCar)

var ferrariClass = FerrariClass.init(2022, "911", 50)
ferrariClass.UploadToCargo(20)
ferrariClass.InitializeCargo(30, .BODY)
ferrariClass.UploadToCargo(10)

if (ferrariClass is CarNitroExtension)
{
    (ferrariClass as CarNitroExtension).onNitro()
}

ferrariClass.onEngineRun()

if (ferrariClass is CarNitroExtension)
{
    (ferrariClass as CarNitroExtension).onNitro()
}