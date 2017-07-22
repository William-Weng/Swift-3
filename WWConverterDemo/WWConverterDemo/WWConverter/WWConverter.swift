//
//  ViewController.swift
//  WWConverterDemo
//
//  Created by William-Weng on 2017/7/22.
//  Copyright © 2017年 William-Weng. All rights reserved.
//

import Foundation

extension String {
    
    public func reverseChinese() -> String? {

        guard let dictionaryPath = Bundle.main.path(forResource: "ChineseDic", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: dictionaryPath) as! Dictionary<String,String>?
        else {
            return nil
        }
        
        let array = self.characters.map() {
            dictionary[String($0)] ?? String($0)
        }
        
        return array.reduce(String(), +)
    }
}
