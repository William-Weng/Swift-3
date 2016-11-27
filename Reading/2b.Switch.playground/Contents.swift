//: Playground - noun: a place where people can play

import UIKit

let vegetable = "red pepper"

switch vegetable {
    case "celery":
        print("Add some raisins and make ants on a log.")
    case "cucumber", "watercress":
        print("That would make a good tea sandwich.")
    case let x where x.hasSuffix("pepper"): // 可以有運算式
        print("Is it a spicy \(x)?")
    default: // 一定要有default
        print("Everything tastes good in soup.")
}