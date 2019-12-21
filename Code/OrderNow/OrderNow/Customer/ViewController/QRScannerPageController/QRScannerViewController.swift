//
//  QRScannerViewController.swift
//  OrderNow
//
//  Created by ADMIN on 9/11/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController,IQRScannerViewController{
    
    let _bookingService = BookingService()
    @IBOutlet weak var icFlash: UIImageView!
    @IBOutlet weak var scannerView: QRScannerView!{
        didSet {
            scannerView.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startScanner()
    }
    
    func startScanner() {
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if scannerView.isRunning {
            scannerView.stopScanning()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func actSupport(_ sender: UITapGestureRecognizer) {
        DispatchQueue.main.async {
            self.present(LocationSupportViewController(), animated: true, completion: nil)
        }
    }
    
    @IBAction func actHome(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actFlash(_ sender: UITapGestureRecognizer) {
        if toggleFlash() {
            icFlash.image = UIImage(named: "ic_flash")
        }else{
            icFlash.image = UIImage(named: "ic_no_flash")
        }
    }
    
}

extension QRScannerViewController : QRScannerViewDelegate  {
    
    func qrScanningDidFail() {
        
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        
        if str?.contains("OrderNow:") ?? false {
            let dataArray = str?.split(separator: ":")
            
            guard let data = dataArray else {
                scannerView.startScanning()
                return
            }
            
            if data.count > 1 {
                BookTable(id: String(data[1]))
            }
            return
        }
        scannerView.startScanning()
    }
    
    func qrScanningDidStop() {
        
    }
    
}

extension QRScannerViewController {
    
    func toggleFlash() -> Bool {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return false}
        guard device.hasTorch else { return false }
        
        do {
            try device.lockForConfiguration()
            
            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }
            
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
        
        return device.torchMode == AVCaptureDevice.TorchMode.on
    }
    
    func BookTable(id:String) {
        _bookingService.BookingTable(id: id ){ (status, data, error) in
            guard let data = data else {
                return
            }
            
            if data.Status == 1 {
                // dat ban thanh cong
                let datMon = OrderPageController()
                self.present(datMon, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
            
            if(data.Status == 2){
                // bàn đang hoạt động
                let popUpUtils = popUpUtilsViewController()
                popUpUtils.scanner = self
                self.present(popUpUtils, animated: true, completion: nil)
                return
            }

            if data.Status != 1 && data.Status != 0 {
                self.scannerView.startScanning()
            }
            
            self.ShowAlertMessage(data.Message)
        }
    }
    
}

protocol IQRScannerViewController {
    func startScanner()
}

extension QRScannerViewController {
    func ShowError(_ error:Error?) -> Void {
        guard let er = error else {
            return
        }
        ShowAlertMessage(er.localizedDescription)
    }
    
    func ShowAlertMessage(_ text:String) -> Void {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert);
        
        let btnClose = UIAlertAction(title: "Đóng", style: .cancel, handler: nil)
        alert.addAction(btnClose)
        
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
