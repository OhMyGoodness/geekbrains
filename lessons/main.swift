//
//  main.swift
//  lesson4
//
//  Created by Данила Лазин on 27.05.2021.
//
//

import Foundation

class Car {
    var CarClass: CarClassType?

    var YearProduction: Int?

    var CarModel: String?

    var isEngineStarted: Bool = false

    var isWindowOpened: Bool = false

    var MyCargo: CargoType = .UNKNOWN

    var CargoCurrentLoad: Float = 0

    var CargoMaxLoad: Float = 0

    init(yearProd: Int, model: String) {
        YearProduction = yearProd
        CarModel = model
    }

    enum CarClassType: String {
        case SPORT = "Спортивный"
        case TRUNK = "Грузовой"
    }

    enum CargoType {
        case UNKNOWN
        case BODY
        case TRUNK
    }

    enum CarActionType {
        case RUN_ENGINE
        case STOP_ENGINE
        case OPEN_WINDOWS
        case CLOSE_WINDOWS
        case UPLOAD_CARGO(volume: Float)
        case UNLOAD_CARGO(volume: Float)
    }

    func onAction(action: CarActionType) {
        switch action {
        case .RUN_ENGINE:
            isEngineStarted = true
            print("Двигатель успешно запущен")
        case .STOP_ENGINE:
            isEngineStarted = false
            print("Двигатель успешно остановлен")
        case .OPEN_WINDOWS:
            isWindowOpened = true
            print("Окна успешно открыты")
        case .CLOSE_WINDOWS:
            isWindowOpened = false
            print("Окна успешно закрыты")
        default:
            break
        }
    }

    final func toString() -> String {
        var cargoClassString: String = "Неизвестно"
        switch MyCargo {
        case .BODY:
            cargoClassString = "Кузов"
        case .TRUNK:
            cargoClassString = "Багажник"
        default:
            break
        }
        return "Модель: \(CarModel!), Год выпуска: \(YearProduction!), Класс авто: \(CarClass!.rawValue), Тип грузового отсека: \(cargoClassString), Максимальный объем груза: \(CargoMaxLoad)"
    }

    final func actionsToString() -> String{
        return "Двигатель: \((isEngineStarted ? "запущен" : "остановлен")), Окна: \((isWindowOpened ? "открыты" : "закрыты"))"
    }
}

class SportCar: Car {
    override init(yearProd: Int, model: String) {
        super.init(yearProd: yearProd, model: model)
        CarClass = .SPORT
        MyCargo = .BODY
    }

    func initCargoSettings(_ maxVolume: Float) {
        CargoMaxLoad = maxVolume
    }

    override func onAction(action: CarActionType) {
        super.onAction(action: action)
        switch action {

        case .UPLOAD_CARGO(volume: let vol):
            let checkCargo = CargoCurrentLoad + vol >= CargoMaxLoad
            if (!checkCargo){
                CargoCurrentLoad += vol
                print("Загружено \(vol), текущий общий объем груза = \(CargoCurrentLoad)")
            } else {
                print("Невозможно выполнить загрузку, объем первышает максимальный")
            }
            break
        case .UNLOAD_CARGO(volume: let vol):
            let checkCargo = CargoCurrentLoad - vol < 0
            if (!checkCargo){
                CargoCurrentLoad -= vol
                print("Выгружено \(vol), текущий общий объем груза = \(CargoCurrentLoad)")
            } else {
                print("Невозможно выполнить разгрузку, указанного объема не существует")
            }
            break;
        default:
            break
        }
    }

}
class TrunkCar: Car {
    override init(yearProd: Int, model: String) {
        super.init(yearProd: yearProd, model: model)
        CarClass = .TRUNK
        MyCargo = .TRUNK
    }

    func initCargoSettings(_ maxVolume: Float) {
        CargoMaxLoad = maxVolume
    }

    override func onAction(action: CarActionType) {
        super.onAction(action: action)
        switch action {

        case .UPLOAD_CARGO(volume: let vol):
            let checkCargo = CargoCurrentLoad + vol >= CargoMaxLoad
            if (!checkCargo){
                CargoCurrentLoad += vol
                print("Загружено \(vol), текущий общий объем груза = \(CargoCurrentLoad)")
            } else {
                print("Невозможно выполнить загрузку, объем первышает максимальный")
            }
            break
        case .UNLOAD_CARGO(volume: let vol):
            let checkCargo = CargoCurrentLoad - vol < 0
            if (!checkCargo){
                CargoCurrentLoad -= vol
                print("Выгружено \(vol), текущий общий объем груза = \(CargoCurrentLoad)")
            } else {
                print("Невозможно выполнить разгрузку, указанного объема не существует")
            }
            break;
        default:
            break
        }
    }

}

var mersCar = SportCar(yearProd: 2021, model: "Mercedes 2021")
mersCar.initCargoSettings(5)
print(mersCar.toString())
print(mersCar.actionsToString())

mersCar.onAction(action: .OPEN_WINDOWS)
mersCar.onAction(action: .UPLOAD_CARGO(volume: 3))
mersCar.onAction(action: .UPLOAD_CARGO(volume: 1))
mersCar.onAction(action: .UNLOAD_CARGO(volume: 1))
mersCar.onAction(action: .UNLOAD_CARGO(volume: 500))

var teslaCar = TrunkCar(yearProd: 2121, model: "Tesla cyber Truck")
teslaCar.initCargoSettings(1000)
print(teslaCar.toString())
print(teslaCar.actionsToString())

teslaCar.onAction(action: .RUN_ENGINE)
teslaCar.onAction(action: .UPLOAD_CARGO(volume: 34))
teslaCar.onAction(action: .UPLOAD_CARGO(volume: 34))
teslaCar.onAction(action: .UNLOAD_CARGO(volume: 34))
teslaCar.onAction(action: .UNLOAD_CARGO(volume: 500))