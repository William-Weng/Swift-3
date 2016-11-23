//: Playground - noun: a place where people can play

import UIKit

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}


class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}


struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() { // enum and struct 要加 mutating 才可以用(改)
        simpleDescription += " (adjusted)"
    }
}

extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}



var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription



var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription



print(7.simpleDescription)
