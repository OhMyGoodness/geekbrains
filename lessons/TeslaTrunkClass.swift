//
// Created by Данила Лазин on 05.06.2021.
//

class TeslaTrunkClass: CustomStringConvertible, CarProtocol, CarCargoProtocol {
    var YearProduction: Int

    var Model: String

    var GasVolume: Float

    var IsWindowOpened: Bool = false

    var IsEngineRunned: Bool = false

    var CargoInitialized: Bool = false

    func getCurrentGasVolume() -> Float {
        return GasVolume
    }

    var CargoProps: CargoProperties? = nil

    var CargoMaxVolume: Float = 0

    required init(_ yearProd: Int, _ model: String, _ gasVolume: Float) {
        YearProduction = yearProd
        Model = model
        GasVolume = gasVolume
        IsWindowOpened = false
        IsEngineRunned = false
        GasVolume = 0.0
        CargoInitialized = false
    }

    /* задумка была сделать инициализатор для разных видов груза, но не стал уже усложнять сильно код */
    func InitializeCargo(_ maxVol: Float, _ type: CargoType) {
        CargoProps = CargoProperties(maxVol, type)
        CargoInitialized = true
    }

    func UploadToCargo(_ volume: Float) -> () {
        if (!CargoInitialized) {
            print("Грузовые параметры не инициализированы")
            return
        }
        let currentCargoLoad = CargoProps!.CargoCurrentVolume + volume

        if (CargoProps!.CargoMaxVolume < currentCargoLoad) {
            print("Невозможно загрузить объем больше чем максимальный для данного транспорта")
        } else {
            CargoProps!.CargoCurrentVolume = currentCargoLoad
            print("Объем \(volume) добавлен в грузовой отсек, текущий объем = \(currentCargoLoad)")
        }
    }

    func UnloadFromCargo(_ volume: Float) -> () {
        if (!CargoInitialized) {
            print("Грузовые параметры не инициализированы")
            return
        }

        let currentCargoLoad = CargoProps!.CargoCurrentVolume - volume

        if (currentCargoLoad < 0) {
            print("Невозможно выгрузить объем больше чем содержиться в транспорте")
        } else {
            CargoProps!.CargoCurrentVolume = currentCargoLoad
            print("Объем \(volume) выгружен из грузового отсека, текущий объем = \(currentCargoLoad)")
        }
    }

    var description: String {
        get {
            return "Класс авто: Грузовая Тесла, Модель: \(Model), Год: \(YearProduction), Окна \((IsWindowOpened) ? "открыты" : "закрыты"), Двигатель: \((IsEngineRunned) ? "запущен" : "остановлен")"
        }
    }
}