//
//  main.swift
//  lesson3
//
//  Created by Данила Лазин on 27.05.2021.
//
//

import Foundation

/* задание 1 - 2 */

struct CarStruct {
    enum CarClassType: String {
        case SPORT = "легковой"
        case TRUNK = "грузовик"
    }

    enum CarActionType {
        case RUN_ENGINE
        case STOP_ENGINE
        case OPEN_WINDOWS
        case CLOSE_WINDOWS
        case UPLOAD_CARGO(volume: Float, type: CargoType)
        case UNLOAD_CARGO(volume: Float, type: CargoType)
    }

    enum CargoType {
        case BODY
        case TRUNK
    }

    private var carClass: CarClassType
    private var carModel: String
    private var carYearProduction: Int
    private var cargoVolume: Dictionary<CargoType, Float> = [.BODY: 0, .TRUNK: 0]
    private var currentCargoVolume: Dictionary<CargoType, Float> = [.BODY: 0, .TRUNK: 0]

    private var isEngineStarted: Bool = false
    private var isWindowsOpened: Bool = false

    init(carClass:CarClassType, model: String, year: Int, bodyCargo: Float = 0, trunkCargo: Float = 0){
        self.carClass = carClass
        self.carModel = model
        carYearProduction = year

        cargoVolume[.BODY] = bodyCargo
        cargoVolume[.TRUNK] = trunkCargo
    }

    func getCarInfo() -> String {
        return "Модель \(carModel), год выпуска \(carYearProduction), класс \(carClass.rawValue)"
                + ", объем кузова \(currentCargoVolume[.BODY]!) из \(cargoVolume[.BODY]!)"
                + ", объем багажника \(currentCargoVolume[.TRUNK]!) из \(cargoVolume[.TRUNK]!)"
                + ", двигатель \(isEngineStarted ? "запущен" : "остановлен")"
                + ", окна \(isWindowsOpened ? "открыты" : "закрыты")"
    }

    mutating func onAction(_ action: CarActionType) -> () {
        switch action {
        case .RUN_ENGINE:
            print((isEngineStarted ? "Двигатель уже запущен" : "Двигатель успешно запущен"))
            isEngineStarted = true
        case .STOP_ENGINE:
            print((!isEngineStarted ? "Двигатель уже остановлен" : "Двигатель успешно остановлен"))
            isEngineStarted = false
        case .OPEN_WINDOWS:
            print((isWindowsOpened ? "Окна уже открыты" : "Окна успешно открыты"))
            isWindowsOpened = true
        case .CLOSE_WINDOWS:
            print((isWindowsOpened ? "Окна уже закрыты" : "Окна успешно закрыты"))
            isWindowsOpened = false
        case .UPLOAD_CARGO(volume: let volume, type: let type):
            switch type {
            case .BODY:
                if (currentCargoVolume[type]! + volume > cargoVolume[type]!) {
                    print("Невозможно добавить груз, т.к. не хватает свободного объема в кузове")
                } else {
                    print("Груз в объеме \(volume) успешно добавлен в кузов")
                    currentCargoVolume[type]! += volume
                }
            case .TRUNK:
                if (currentCargoVolume[type]! + volume > cargoVolume[type]!) {
                    print("Невозможно добавить груз, т.к. не хватает свободного объема в багажнике")
                } else {
                    print("Груз в объеме \(volume) успешно добавлен в багажник")
                    currentCargoVolume[type]! += volume
                }
            }
        case .UNLOAD_CARGO(volume: let volume, type: let type):
            if (currentCargoVolume[type]! - volume < 0) {
                switch type {
                case .BODY:
                    print("В кузове находится недостаточный объем груза для выгрузки")
                case .TRUNK:
                    print("В багажнике находится недостаточный объем груза для выгрузки")
                }
                break
            } else {
                switch type {
                case .BODY:
                    print("Груз в объеме \(volume) успешно выгружен из кузова")
                case .TRUNK:
                    print("Груз в объеме \(volume) успешно выгружен из багажника")
                }

            }
            currentCargoVolume[type]! -= volume
        }
    }
}

var toyotaCar = CarStruct(carClass: .SPORT, model: "Toyota RAV", year: 2021, bodyCargo: 2, trunkCargo: 0)
var mersCar = CarStruct(carClass: .TRUNK, model: "Мерс", year: 2100, bodyCargo: 3, trunkCargo: 500)

toyotaCar.onAction(.RUN_ENGINE)
toyotaCar.onAction(.STOP_ENGINE)
toyotaCar.onAction(.STOP_ENGINE) // повторная остановка

toyotaCar.onAction(.OPEN_WINDOWS)
toyotaCar.onAction(.UPLOAD_CARGO(volume: 99, type: .BODY))
toyotaCar.onAction(.UPLOAD_CARGO(volume: 2, type: .BODY))

toyotaCar.onAction(.UNLOAD_CARGO(volume: 1, type: .BODY))
toyotaCar.onAction(.UNLOAD_CARGO(volume: 1, type: .TRUNK))

mersCar.onAction(.RUN_ENGINE)
//
mersCar.onAction(.UPLOAD_CARGO(volume: 200, type: .TRUNK))
print(toyotaCar.getCarInfo())
print(mersCar.getCarInfo())
