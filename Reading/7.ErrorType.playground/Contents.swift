//: Playground - noun: a place where people can play

import UIKit

enum PrinterError: Error {
    case outOfPaper // error的種類
    case noToner
    case onFire
}

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner // 產生錯誤
    }
    
    if printerName == "onFire" {
        throw PrinterError.onFire
    }
    
    return "Job sent"
}

do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    // let printerResponse2 = try send(job: 1040, toPrinter: "Never Has Toner")
    print(printerResponse)
} catch {
    print(error) // 預設error變數就是錯誤碼(可以改嗎？)
}


do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    print(printerResponse)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}


let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler") // 沒錯誤就傳回該傳的值
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner") // 發生error就會傳回nil



var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(food)
    return result
}

fridgeContains("banana")
print(fridgeIsOpen)
