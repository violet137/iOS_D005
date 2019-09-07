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

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        self.Login(user.authentication.idToken)
        
//        // Perform any operations on signed in user here.
//        let userId = user.userID                  // For client-side use only!
//        let idToken = user.authentication.idToken // Safe to send to the server
//        let fullName = user.profile.name
//        let givenName = user.profile.givenName
//        let familyName = user.profile.familyName
//        let email = user.profile.email
    }
    
    
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
        
        GIDSignIn.sharedInstance()?.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func evPhoneChange(_ sender: UITextField) {
        if isResendOTP
        {
            isResendOTP = false
            otpView.text = nil
            btnContinueView.setTitle("Gửi OTP", for: .init())
        }
    }
    
    @IBAction func actContinue(_ sender: Any) {
        
        if(phoneView.text == "" || phoneView.text == nil){
            return
        }
        let phone = phoneView.text!
        
        if !isResendOTP
        {
            let r = API_SendOTP(phone)
            if r.status {
                isResendOTP = true
                otpView.isHidden = false
                btnResendOTPView.isHidden = false
                btnContinueView.setTitle("Đăng nhập", for: .init())
                otpView.becomeFirstResponder()
            }else{
                ShowError(r.error)
            }
        }else{
            
            if(otpView.text == "" || otpView.text == nil){
                return
            }
            
            let otp = otpView.text!
            
            Login(phone,otp)
        }
    }
    
    @IBAction func actResendOTP(_ sender: Any) {
    }
    
    @IBAction func actLoginGG(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func actLofinFB(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.email,], viewController: self) { (LoginResult) in
            switch(LoginResult){
            case .cancelled:
                
                break;
            case .failed(let error):
                
                break;
            case .success(_,_,let token):
                self.Login(token.tokenString)
                break;
            }
        }
    }
    
    func Login(_ token:String) -> Void {
        let r = API_Login(token)
        if r.status {
            ShowAlertMessage("""
            Login Thành Công
            Xin Chào \(token)
            """)
        }else{
            ShowError(r.error)
        }
    }
    
    func Login(_ phone:String, _ otp:String) -> Void {
        AuthorizationService.Login(phoneNumber: phone, otp: otp) { (status, error) in
            if status {
                self.ShowAlertMessage("""
                    Login Thành Công
                    Xin Chào \(phone)
                    """)
            }else{
//                self.ShowError(String(describing: error))
                self.ShowError("Login Thất bại")
            }
        }
    }
    
    func API_Login(_ token:String) -> (status: Bool, error: String?) {
        return (true,nil)
    }
    
    func API_SendOTP(_ phone:String) -> (status: Bool, error: String?) {
        return (true,nil)
    }
    
    func ShowError(_ error:String?) -> Void {
        guard let er = error else {
            return
        }
        ShowAlertMessage(er)
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


