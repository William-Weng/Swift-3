//: Playground - noun: a place where people can play

import UIKit

var n = 2
var m = 2
var total = 0

while n < 100 {
    n = n * 2
}

repeat { // repeat...while ==> 至少會執行一次
    m = m * 2
} while m < 100

for i in 0..<4 { // for...in ==> 設定區間
    total += i
}

print(n)
print(m)
print(total)