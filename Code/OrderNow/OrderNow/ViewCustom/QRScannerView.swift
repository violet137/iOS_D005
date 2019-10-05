//
//  QRScannerView.swift
//  QRCodeReader
//
//  Created by KM, Abhilash a on 08/03/19.
//  Copyright © 2019 KM, Abhilash. All rights reserved.
//  Source : https://github.com/abhimuralidharan/QRScanner

import Foundation
import UIKit
import AVFoundation
import SnapKit

/// Delegate callback for the QRScannerView.
protocol QRScannerViewDelegate: class {
    func qrScanningDidFail()
    func qrScanningSucceededWithCode(_ str: String?)
    func qrScanningDidStop()
}

class QRScannerView: UIView {
    
    weak var delegate: QRScannerViewDelegate?
    
    /// capture settion which allows us to start and stop scanning.
    var captureSession: AVCaptureSession?
    
    // Init methods..
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        doInitialSetup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        doInitialSetup()
    }
    
    // Draw border view
    func drawBorderView() -> Void {
        
        let boxViewFrame = UIView()
        self.addSubview(boxViewFrame)
        boxViewFrame.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(50)
            make.trailing.equalTo(self).inset(50)
            make.height.equalTo(boxViewFrame.snp.width).multipliedBy(0.8)
        }
        
        let boxViewColor = UIColor.green
        let boxViewSize = 4
        let boxViewWidth = 0.167
        let boxViewHeight = 0.142857
        
        let boxView1 = UIView()
        boxView1.backgroundColor = boxViewColor
        boxViewFrame.addSubview(boxView1)
        boxView1.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(boxViewFrame)
            make.leading.equalTo(boxViewFrame)
            make.height.equalTo(boxViewSize)
            make.width.equalTo(boxViewFrame.snp.width).multipliedBy(boxViewWidth)
        }
        
        let boxView2 = UIView()
        boxView2.backgroundColor = boxViewColor
        boxViewFrame.addSubview(boxView2)
        boxView2.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(boxViewFrame)
            make.leading.equalTo(boxViewFrame)
            make.height.equalTo(boxViewSize)
            make.width.equalTo(boxViewFrame.snp.width).multipliedBy(boxViewWidth)
        }
        
        let boxView3 = UIView()
        boxView3.backgroundColor = boxViewColor
        boxViewFrame.addSubview(boxView3)
        boxView3.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(boxViewFrame)
            make.trailing.equalTo(boxViewFrame)
            make.height.equalTo(boxViewSize)
            make.width.equalTo(boxViewFrame.snp.width).multipliedBy(boxViewWidth)
        }
        
        let boxView4 = UIView()
        boxView4.backgroundColor = boxViewColor
        boxViewFrame.addSubview(boxView4)
        boxView4.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(boxViewFrame)
            make.trailing.equalTo(boxViewFrame)
            make.height.equalTo(boxViewSize)
            make.width.equalTo(boxViewFrame.snp.width).multipliedBy(boxViewWidth)
        }
        
        let boxView5 = UIView()
        boxView5.backgroundColor = boxViewColor
        boxViewFrame.addSubview(boxView5)
        boxView5.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(boxViewFrame)
            make.leading.equalTo(boxViewFrame)
            make.width.equalTo(boxViewSize)
            make.height.equalTo(boxViewFrame.snp.height).multipliedBy(boxViewHeight)
        }
        
        let boxView6 = UIView()
        boxView6.backgroundColor = boxViewColor
        boxViewFrame.addSubview(boxView6)
        boxView6.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(boxViewFrame)
            make.trailing.equalTo(boxViewFrame)
            make.width.equalTo(boxViewSize)
            make.height.equalTo(boxViewFrame.snp.height).multipliedBy(boxViewHeight)
        }
        
        let boxView7 = UIView()
        boxView7.backgroundColor = boxViewColor
        boxViewFrame.addSubview(boxView7)
        boxView7.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(boxViewFrame)
            make.leading.equalTo(boxViewFrame)
            make.width.equalTo(boxViewSize)
            make.height.equalTo(boxViewFrame.snp.height).multipliedBy(boxViewHeight)
        }
        
        let boxView8 = UIView()
        boxView8.backgroundColor = boxViewColor
        boxViewFrame.addSubview(boxView8)
        boxView8.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(boxViewFrame)
            make.trailing.equalTo(boxViewFrame)
            make.width.equalTo(boxViewSize)
            make.height.equalTo(boxViewFrame.snp.height).multipliedBy(boxViewHeight)
        }
        
        
    }
    
    //MARK: overriding the layerClass to return `AVCaptureVideoPreviewLayer`.
    override class var layerClass: AnyClass  {
        return AVCaptureVideoPreviewLayer.self
    }
    override var layer: AVCaptureVideoPreviewLayer {
        return super.layer as! AVCaptureVideoPreviewLayer
    }
}
extension QRScannerView {
    
    var isRunning: Bool {
        return captureSession?.isRunning ?? false
    }
    
    func startScanning() {
       captureSession?.startRunning()
    }
    
    func stopScanning() {
        captureSession?.stopRunning()
        delegate?.qrScanningDidStop()
    }
    
    /// Does the initial setup for captureSession
    private func doInitialSetup() {
        clipsToBounds = true
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch let error {
            print(error)
            return
        }
        
        if (captureSession?.canAddInput(videoInput) ?? false) {
            captureSession?.addInput(videoInput)
        } else {
            scanningDidFail()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession?.canAddOutput(metadataOutput) ?? false) {
            captureSession?.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417]
        } else {
            scanningDidFail()
            return
        }
        
        self.layer.session = captureSession
        self.layer.videoGravity = .resizeAspectFill
        
        captureSession?.startRunning()
        
        drawBorderView()
    }
    func scanningDidFail() {
        delegate?.qrScanningDidFail()
        captureSession = nil
    }
    
    func found(code: String) {
        delegate?.qrScanningSucceededWithCode(code)
    }
    
}

extension QRScannerView: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        stopScanning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
}
