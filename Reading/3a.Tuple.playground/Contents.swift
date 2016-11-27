//: Playground - noun: a place where people can play

import UIKit

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) { // 回傳值可以是元組(tuple) ==> 不可改值的array
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum) // 其實裡面的 min ==> 0 / max ==> 1
}

func sumOf(numbers: Int...) -> Int { // 可變數量的變數 ==> tuple
    var sum = 0
    
    for number in numbers {
        sum += number
    }
    return sum
}

let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])

print(statistics.sum)
print(statistics.2)

sumOf()
sumOf(numbers: 42, 597, 12)
