//
//  AlbumViewController.swift
//  ScanQRcode
//
//  Created by William-Weng on 2017/5/8.
//  Copyright © 2017年 William-Weng. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: ----- IBOutlet -----
    @IBOutlet weak var scanData: UITextField!  // 掃瞄到的內容
    @IBOutlet weak var scanImage: UIImageView! // 儲存QR-Code圖片
    
    // MARK: ----- View life -----
    override func viewDidLoad() {
        super.viewDidLoad()
        scanData.isUserInteractionEnabled = false // 不要讓輸入框能輸入文字
    }
    
    // MARK: ----- UIImagePickerControllerDelegate -----
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage // 獲得從相簿選擇出的圖片
        let features = self.parseQRCodeImage(image: image)
        
        for feature in features { // 掃完所有的二維碼後輸出
            scanData.text = feature.messageString!
        }
        
        scanImage.image = image
        picker.dismiss(animated: true, completion:nil) // 圖片控制器退出
        
        if features.count <= 0 {
            self.isParseQRCodeError()
        } else {
            self.isParseQRCodeSuccess()
        }
    }
    
    // MARK: ----- @IBAction -----
    // 復制文字框上的文字
    @IBAction func copyText(_ sender: UIButton) {
        
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = scanData.text
        
        if let string = pasteBoard.string{ isCopyTextOK(string:string) }
    }
    
    // 開啟相簿
    @IBAction func openAlbum(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) { // 判斷設置是否支援相簿存取
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary

            self.present(picker, animated: true, completion: nil)
        } else {
            print("相簿讀取錯誤")
        }
    }
    
    // MARK: ----- WilliamTools -----
    // 圖片 ==> QRCode
    func parseQRCodeImage(image: UIImage) -> [CIQRCodeFeature] {
        
        let ciImage: CIImage = CIImage(image: image)!
        let context = CIContext(options: nil)
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        let features = detector?.features(in: ciImage)
        
        print("掃瞄到二維碼個數：\(features?.count ?? 0)")
        
        return features as! [CIQRCodeFeature]
    }
    
    // MARK: ----- PromptBox -----
    // 複製成功的提示框
    func isCopyTextOK(string:String) {
        
        let alertController = UIAlertController( // 建立一個提示框
            title: "提示",
            message: "已複製[\(string)]到剪貼簿",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction( // 建立[確認]按鈕
            title: "確認",
            style: .default,
            handler: { (action: UIAlertAction!) -> Void in
                print("已複製到剪貼簿")}
        )
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil) // 顯示提示框
    }
    
    // QRCode解析錯誤
    func isParseQRCodeError() {
        
        let alertController = UIAlertController( // 建立一個提示框
            title: "提示",
            message: "沒有辨識到QRCode",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction( // 建立[確認]按鈕
            title: "確認",
            style: .default,
            handler: { (action: UIAlertAction!) -> Void in
                print("沒有辨識到QRCode")}
        )
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil) // 顯示提示框
    }
    
    // QRCode解析成功
    func isParseQRCodeSuccess() {
        
        let alertController = UIAlertController( // 建立一個提示框
            title: "提示",
            message: "QRCode解析成功",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction( // 建立[確認]按鈕
            title: "確認",
            style: .default,
            handler: { (action: UIAlertAction!) -> Void in
                print("QRCode解析成功")}
        )
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil) // 顯示提示框
    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }

}
