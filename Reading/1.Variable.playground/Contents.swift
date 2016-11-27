//: Playground - noun: a place where people can play

import UIKit

var variable = 9.5 // 變數 ==> 沒有型態，就要給初值 ==> 自動產生型態
var myVariable:Int // 變數 ==> 有型態 ==> 不用給初值(但還是沒有初始化)
let PI = 3.14159 // 常數
let Math_PI:Double // 常數
let Title = "Hello World, "

let myString = Title + String(PI) // 文字 + 數字 ==> 轉型
let myString2 = "Math_PI = \(PI)" // 文字 + \(數字)

variable = 10 // 變數 ==> 可以改變其值
// PI = 3.14 // 常數 ==> 不能設定兩次值
// myVariable // 沒有初始值
myVariable = 10
Math_PI = 3.14
// Math_PI = 3.1415 // 常數 ==> 不能設定兩次值
