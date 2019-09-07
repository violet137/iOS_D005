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
            
            let alertController = UIAlertController(title: "Title", message:
                "What is the Sub-Total!", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)

            
            return
        }
        let phone = phoneView.text!
        if !isResendOTP {
            SendOTP(phone)
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
    
    func SendOTP(_ phone:String) -> Void {
        AuthorizationService.Register(phoneNumber: phone) { (status, error) in
//            if status {
                DispatchQueue.main.async {
                    self.isResendOTP = true
                    self.otpView.isHidden = false
                    self.btnResendOTPView.isHidden = false
                    self.btnContinueView.setTitle("Đăng nhập", for: .init())
                    self.otpView.becomeFirstResponder()
                }
//            }else{
//                if(error != nil){
//                    self.ShowError(String(describing: error!.localizedDescription))
//                }
//            }
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
                if(error != nil){
                    self.ShowError(error)
                }
            }
        }
    }
    
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
    
    //Login Extension
    func Login(_ token:String) -> Void {
        let r = API_Login(token)
        if r.status {
            ShowAlertMessage("""
                Login Thành Công
                Xin Chào \(token)
                """)
        }else{
//            ShowError(r.error)
        }
    }
    
    func API_Login(_ token:String) -> (status: Bool, error: String?) {
        return (true,nil)
    }
    //Facebook
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
    //Google
    @IBAction func actLoginGG(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
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
    }
    
    
    
}


