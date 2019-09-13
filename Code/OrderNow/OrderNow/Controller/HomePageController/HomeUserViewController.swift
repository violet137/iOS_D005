//
//  HomeUserViewController.swift
//  OrderNow
//
//  Created by ADMIN on 9/11/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import AVFoundation


class HomeUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func actOrder(_ sender: Any) {
        
        // Check Permission
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            GoToQRScannerView()
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    self.GoToQRScannerView()
                } else {
                    //access denied
                }
            })
            break
        default:
            let alert = UIAlertController(title: "Thông báo", message: "Camera access required to scan QRCode", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Settings", style: .default) { (alert) -> Void in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            })
            
            present(alert, animated: true)
            break
        }
    }
    
    func GoToQRScannerView() -> Void {
        let qrScanner = QRScannerViewController()
        DispatchQueue.main.async {
            self.present(qrScanner, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
