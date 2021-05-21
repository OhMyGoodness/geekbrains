import Foundation

let contribYears:Int = 5

print("Введите сумму вклада: ")
let inputSumm:String? = readLine()
if (inputSumm != nil)
{
    print("Введите годовой процент: ")
    let percentInput:String? = readLine()
    
    if (percentInput != nil){
        let percent:Double = Double(percentInput!)! / 100
        
        var totalSumm:Double = Double(inputSumm!)!
        for index in 1...5
        {
            totalSumm += (totalSumm*percent)
        }
        
        print("Сумма вклада = " + inputSumm! + ", годовой процент: " + percentInput! +
                ", сумма вкалада через " + String(contribYears) + " лет = " + String(format: "%.00f", totalSumm))
    }
}
