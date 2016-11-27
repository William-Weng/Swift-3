//: Playground - noun: a place where people can play

import UIKit

func greet(person: String, day: String) -> String { // (函數值) -> 回傳值
    return "Hello \(person), today is \(day)."
}

func greet(_ person: String, on day: String) -> String { // _ 可以把參數名省略
    return "Hello \(person), today is \(day)."
}

greet(person: "Bob", day: "Tuesday")
greet("John", on: "Wednesday")