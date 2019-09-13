//
//  ViewController.swift
//  OrderNow
//
//  Created by ADMIN on 8/26/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let view = LoginViewController()
//        let view = QRScannerViewController()
        let view = HomeUserViewController()
        DispatchQueue.main.async {
            self.present(view, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

}
