//
// Лазин Данил Николаевич 09/06/2021
//  main.swift
//  lesson6

import Foundation

enum MyThrows: Error {
    case method_is_return_null
}

protocol MyFilterProtocol{
    func getYear() -> Int?
}

class Car: CustomStringConvertible, MyFilterProtocol{
    var name: String = ""
    var year: Int = 0

    var description: String {
        return "Car name: \(name), Year production: \(year)"
    }

    init(_ name: String, _ year: Int) {
        self.name = name
        self.year = year
    }

    func getYear() -> Int? {
        return self.year
    }
}

class MyQueue<T>: MyFilterProtocol{
    private var _items: [T] = []

    init(){

    }

    func enQueue(_ item: T) -> (){
        _items.append(item)
    }

    func deQueue() -> T{
        let result = _items[0]
        _items.remove(at: 0)

        return result
    }

    func getSize() -> Int{
        return _items.count
    }

    func getYear() -> Int? {
        return nil
    }

    func getItemsByYear(_ year: Int) -> [T] {
        _items.filter { item in
            if item is MyFilterProtocol{
                return (item as! MyFilterProtocol).getYear() == year
            } else {
                return false
            }
        }
    }
}

extension MyQueue{
    subscript(index:Int) -> T? {
        return index >= getSize() ? nil : _items[index]
    }
}
var queue = MyQueue<Car>()

queue.enQueue(Car("BMW", 2019))
queue.enQueue(Car("Ferrari", 2020)) // index 1
queue.enQueue(Car("Mercedes", 2021))
queue.enQueue(Car("Tesla", 2021))

let cars2021yrs = queue.getItemsByYear(2021)
for item in cars2021yrs{
    print(item.description)
}

var testItem = queue[1]
var testItem2 = queue[849]
print("============= Test subscript =============")
print(testItem)
print(testItem2)
