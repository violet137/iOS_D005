//
//  LoginViewController.swift
//  OrderNow
//
//  Created by ADMIN on 8/26/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    @IBOutlet weak var phoneView: UITextField!
    @IBOutlet weak var otpView: UITextField!
    @IBOutlet weak var btnContinueView: UIButton!
    @IBOutlet weak var btnResendOTPView: UIButton!
    
    var isResendOTP = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @IBAction func evPhoneChange(_ sender: UITextField) {
        if isResendOTP
        {
            isResendOTP = false
            btnContinueView.setTitle("Gửi OTP", for: .init())
        }
    }
    
    @IBAction func actContinue(_ sender: Any) {
        if !isResendOTP
        {
            isResendOTP = true
            btnContinueView.setTitle("Đăng nhập", for: .init())
        }
    }
    
    @IBAction func actResendOTP(_ sender: Any) {
    }
    
    @IBAction func actLoginGG(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func actLofinFB(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.adsRead,], viewController: self) { (LoginResult) in
            switch(LoginResult){
            case .cancelled:
                
                break;
            case .failed(let error):
                
                break;
            case .success(_,_,let token):
                
                break;
                
            }
        }
    }
    
}
