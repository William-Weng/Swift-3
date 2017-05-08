//
//  ViewController.swift
//  ScanQRcode
//
//  Created by William-Weng on 2017/5/8.
//  Copyright © 2017年 William-Weng. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage

enum Running {
    case start
    case stop
}

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // MARK: ----- IBOutlet -----
    @IBOutlet weak var scanQRCode: UIButton!      // 掃瞄QR-Code
    @IBOutlet weak var saveQRCodeImage: UIButton! // 儲存QR-Code圖片
    @IBOutlet weak var copyScanData: UIButton!    // 複製該文字框內容
    @IBOutlet weak var scanData: UITextField!     // 掃瞄到的內容
    @IBOutlet weak var scanView: UIView!          // 掃瞄的View
    @IBOutlet weak var scanImage: UIImageView!    // 掃瞄預覽畫面的位置
    
    // MARK: ----- Variable -----
    var captureSession: AVCaptureSession!         // 處理設備擷取下來的資料
    var previewLayer: AVCaptureVideoPreviewLayer! // scan的預覽畫面
    
    // MARK: ----- View life -----
    // viewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) // 設定前camera為擷取的裝置
        let videoInput: AVCaptureDeviceInput
        let metadataOutput = AVCaptureMetadataOutput()          // 啟用檢測人臉和二維碼

        self.tabBarController!.tabBar.tintColor = UIColor.black // 讓tab的預設圖示顏色為黑色
        self.scanView.layer.cornerRadius = 10                   // 讓scanView有圓角
        scanData.isUserInteractionEnabled = false               // 不要讓輸入框能輸入文字
        
        captureSession = AVCaptureSession()
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        self.canAddDeviceInput(videoInput: videoInput)
        self.canAddMetadataOutput(metadataOutput: metadataOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = scanImage.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        scanImage.layer.addSublayer(previewLayer); // 把scan的view放在imageview的位置上
        
        captureSession.startRunning();
    }

    // viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.runningScan(running: .start)
    }
    
    // viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.runningScan(running: .stop)
    }

    // MARK: ----- @IBAction -----
    // 重新開始掃瞄
    @IBAction func scanQRCode(_ sender: UIButton) { self.runningScan(running: .start) }
    
    // 復制文字框上的文字
    @IBAction func copyText(_ sender: UIButton) {
        
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = scanData.text
        
        if let string = pasteBoard.string{ isCopyTextOK(string:string) }
    }
    
    // 儲存QRCode的圖片至相簿
    @IBAction func saveQRCode(_ sender: UIButton) {
        
        self.runningScan(running: .stop)
        self.previewLayer.isHidden = true
        self.scanImage.image = createQRCodeImage(string: scanData.text!, iconImageName: "QRCode")
        self.saveGraphic()
    }
    
    // MARK: ----- AVCaptureMetadataOutputObjectsDelegate -----
    // 掃瞄成功後輸出…
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: readableObject.stringValue);
        }
        
        dismiss(animated: true)
    }
    
    // MARK: ----- WilliamTools -----
    // 找到QRCode時…
    func found(code: String) {
        scanData.text = code
        print(code)
    }
    
    // 設定scan開關
    func runningScan(running:Running) {

        if self.previewLayer.isHidden { self.previewLayer.isHidden = false }
        
        switch running {
        case .start:
            if (captureSession?.isRunning == false) { captureSession.startRunning() }
        case .stop:
            if (captureSession?.isRunning == true) { captureSession.stopRunning() }
        }
    }
    
    // 畫一張同樣的圖存到相簿去
    func saveGraphic() {
        
        UIGraphicsBeginImageContext(self.scanImage.frame.size)
        self.scanImage.layer.render(in: UIGraphicsGetCurrentContext()!)
        let graphic = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(graphic!, self, nil, nil)
        
        self.isSaveGraphicOK()
    }

    // MARK: ----- CameraTest -----
    // 找不到相機時…
    func failed() {
        let alertController = UIAlertController(title: "不支持掃描", message: "您的設備不支持掃描代碼，請使用帶有相機的設備。", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
        captureSession = nil
    }
    
    // 測試可否加入設備
    func canAddDeviceInput(videoInput:AVCaptureDeviceInput) {

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
    }
    
    // 測試可否加入metadata設定
    func canAddMetadataOutput(metadataOutput:AVCaptureMetadataOutput) {
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main) // 設定在主執行序執行
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode] // 設定掃瞄的類型為QRCode
        } else {
            failed()
            return
        }
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .portrait }
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
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
    
    func isSaveGraphicOK() {
        
        let alertController = UIAlertController( // 建立一個提示框
            title: "提示",
            message: "已複製圖片到相簿",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction( // 建立[確認]按鈕
            title: "確認",
            style: .default,
            handler: { (action: UIAlertAction!) -> Void in
                print("已複製到相簿")}
        )
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil) // 顯示提示框
    }
}
