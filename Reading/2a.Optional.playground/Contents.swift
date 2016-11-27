//: Playground - noun: a place where people can play

import UIKit

var optionalString:String? // ? ==> optional變數 ==> 可以存nil值
var optionalName:String? = "William"
let nickName:String? = nil
let fullName:String = "William-Weng"

if let name = optionalName {
    print("My name is \(name)")
    print("My name is \(optionalName)")
}

print("Hi \(nickName ?? fullName)") // 第一選項 ?? 第二選項 ==> 預設值