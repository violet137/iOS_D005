//
//  QRScannerViewController.swift
//  OrderNow
//
//  Created by ADMIN on 9/11/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController,QRScannerViewDelegate {
    
    @IBOutlet weak var scannerView: QRScannerView!{
        didSet {
            scannerView.delegate = self
        }
    }
    
    func qrScanningDidFail() {
        
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        print(str)
    }
    
    func qrScanningDidStop() {
        
    }
    
    @IBOutlet weak var icFlash: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !scannerView.isRunning {
            scannerView.stopScanning()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func actSupport(_ sender: UITapGestureRecognizer) {
        print("actSupport")
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
}
