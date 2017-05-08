//
//  File.swift
//  ScanQRcode
//
//  Created by William-Weng on 2017/5/8.
//  Copyright © 2017年 William-Weng. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage

extension ViewController {
    
    func createQRCodeImage(string : String?,iconImageName: String?) -> UIImage? {
        
        let filter = CIFilter(name: "CIQRCodeGenerator") // 創建二維碼濾鏡 固定格式 參數必須為 : CIQRCodeGenerator
        filter?.setDefaults() // 複數位濾鏡,以便下次使用
        
        guard string != nil else { return nil }
        
        let inputData = string!.data(using: String.Encoding.utf8)
        filter?.setValue(inputData, forKey: "inputMessage")
        filter?.setValue("M", forKey: "inputCorrectionLevel") // 設置錯誤復原能力 一般設置為Ｍ
        
        guard let image = filter?.outputImage else { return nil } // 接收濾鏡回傳的圖片,由於太小 需要拉伸放大
        
        let colorFilter = CIFilter(name: "CIFalseColor") //顏色濾鏡
        colorFilter?.setDefaults()
        colorFilter?.setValue(image, forKey: "inputImage")
        
        colorFilter?.setValue(CIColor(red: 30/255.0, green: 30/255.0,blue: 30/255.0), forKey: "inputColor0") //前景色
        colorFilter?.setValue(CIColor(red: 1.0, green: 1.0,blue: 1.0), forKey: "inputColor1") //背景色
        
        guard let colorImage = colorFilter?.outputImage else{ return nil }
        
        let matrix = CGAffineTransform(scaleX: 25, y: 25) //放大25倍 重新繪製
        let QRImage = UIImage(ciImage:colorImage.applying(matrix)) //將 CIImage 轉換為 UIImage
        
        guard iconImageName != nil else { return nil }
        
        return QRImage
    }
}
