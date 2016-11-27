//: Playground - noun: a place where people can play

import UIKit

let mathScore = [35, 60, 77]
var levelScore = 0

for score in mathScore {
    if score > 50 {
        levelScore += 3
    } else {
        levelScore += 1
    }
}

levelScore