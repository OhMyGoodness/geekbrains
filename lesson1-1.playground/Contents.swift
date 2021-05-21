import Foundation

//ax^ + bx + c = 0
//x - unknown
let a:Double = 2
let b:Double = 3
let c:Double = 4

var x1:Double
var x2:Double

let resultDisc = pow(b, 2) - (4*a*c)

if (resultDisc < 0)
{
    print("Квадратное уравнение не имеет корней")
}
else if (resultDisc == 0)
{
    let x1 = -b / (2*a)
    let x2 = x1
    printResult(x1: x1, x2: x2)
}
else{
    let x1 = sqrt(-b + sqrt(resultDisc)) / (2 * a)
    let x2 = sqrt(-b - sqrt(resultDisc)) / (2 * a)
    
    printResult(x1: x1, x2: x2)
}

func printResult(x1: Double, x2: Double) {
   print("x1 = " + String(x1) + "; x2 = " + String(x2))
}
