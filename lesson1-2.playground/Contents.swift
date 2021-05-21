import Foundation

let a: Int = 2
let b: Int = 5

// площадь по 2м катетам
let s: Double = Double(a) * Double(b) / 2

print("Площадь треугольника = " + String(s))

let perrimeter: Double = (sqrt(pow(Double(a), 2) + pow(Double(b), 2) + (Double(a + b))))
print("Периметр треугольника: " + String(perrimeter))
