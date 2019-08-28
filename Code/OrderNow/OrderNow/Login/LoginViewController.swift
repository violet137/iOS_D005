//
//  LoginViewController.swift
//  OrderNow
//
//  Created by Nguyen Thanh Phong on 8/26/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionLoginFacebook(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile], viewController: self) { result in
            let alertController:UIAlertController
            switch result {
            case .cancelled:
                alertController = UIAlertController(title: "login", message: "vui long login lai di, neu tiep tuc su dung app", preferredStyle: .alert)
            case .failed(let error):
                    alertController = UIAlertController(title: "login", message: "login that bai, vui long thu lai nhe", preferredStyle: .alert)
            case .success(_, _, let token):
                alertController = UIAlertController(title: "thanh cong", message: "token:\(token.tokenString)", preferredStyle: .alert)
                break
            }
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
}
