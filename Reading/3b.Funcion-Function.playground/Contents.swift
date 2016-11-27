//: Playground - noun: a place where people can play

import UIKit

func returnFifteen() -> Int {
    var y = 10
    
    func add() { // function內的function
        y += 5
    }
    
    add()
    return y
}

func makeIncrementer() -> ((Int) -> Int) { // 把function當回傳值
    
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    
    return addOne
}

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool { // 把function當參數
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var increment = makeIncrementer()
var numbers = [20, 19, 7, 12]

returnFifteen()
increment(7)
hasAnyMatches(list: numbers, condition: lessThanTen)
