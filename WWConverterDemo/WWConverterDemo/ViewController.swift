//
//  ViewController.swift
//  WWConverterDemo
//
//  Created by William-Weng on 2017/7/22.
//  Copyright © 2017年 William-Weng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("简 => 正: " + "iOS开发之一个方法实现任意内容繁简互转(非本地化)".reverseChinese()!)
        print("正 => 简: " + "iOS開發之一個方法實現任意內容繁簡互轉(非本地化)".reverseChinese()!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

