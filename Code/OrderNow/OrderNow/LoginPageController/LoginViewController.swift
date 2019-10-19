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
import Firebase

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    
    @IBOutlet weak var phoneView: UITextField!
    @IBOutlet weak var otpView: UITextField!
    @IBOutlet weak var btnContinueView: UIButton!
    @IBOutlet weak var btnResendOTPView: UIButton!
    
    var isResendOTP = false
    var _authorizationService = AuthorizationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneView.text = "0902002455"
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        GIDSignIn.sharedInstance()?.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func evOTPChange(_ sender: Any) {
        otpView.backgroundColor = UIColor.white
    }
    
    @IBAction func evPhoneChange(_ sender: UITextField) {
        phoneView.backgroundColor = UIColor.white
        if isResendOTP
        {
            isResendOTP = false
            otpView.text = nil
            btnContinueView.setTitle("Gửi OTP", for: .init())
        }
    }
    
    @IBAction func actContinue(_ sender: Any) {
        if(phoneView.text == "" || phoneView.text == nil || !ValidationPhoneNumber(phoneView.text)){
            phoneView.backgroundColor = UIColor.red
            return
        }
        let phone = phoneView.text!
        if !isResendOTP {
            SendOTP(phone)
        }else{
            if(otpView.text == "" || otpView.text == nil || !ValidationOTP(otpView.text)){
                otpView.backgroundColor = UIColor.red
                return
            }
            let otp = otpView.text!
            Login(phone,otp)
        }
    }
    
    @IBAction func actResendOTP(_ sender: Any) {
        if(phoneView.text == "" || phoneView.text == nil || !ValidationPhoneNumber(phoneView.text)){
            phoneView.backgroundColor = UIColor.red
            return
        }
        let phone = phoneView.text!
        SendOTP(phone)
    }
    
    func SendOTP(_ phone:String) -> Void {
        // SendOTP
        _authorizationService.Register(phoneNumber: phone)
        
        // Update Layout
        self.isResendOTP = true
        self.otpView.isHidden = false
        self.btnResendOTPView.isHidden = false
        self.btnContinueView.setTitle("Đăng nhập", for: .init())
        self.otpView.becomeFirstResponder()
    }
    
    func Login(_ phone:String, _ otp:String) -> Void {
        _authorizationService.Login(phoneNumber: phone, otp: otp) { (status, data, error) in
            if status {
                
                guard let d = data else {
                    return
                }
                
                if d.TypeAcc == "1" {
                    DispatchQueue.main.async {
                        self.present(QRScannerViewController(), animated: true, completion: nil)
                    }
                } else if d.TypeAcc == "2" {
                    let storeyboard = UIStoryboard(name: "Main", bundle: nil)
                    let view = storeyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
                    DispatchQueue.main.async {
                        self.present(view, animated: true, completion: nil)
                    }
                    
//                    var home = HomePageController()
//                    self.present(home, animated: false, completion: nil)
                }
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
    
    //Validation
    func ValidationPhoneNumber(_ phone:String?) -> Bool {
        var result = false
        if phone != nil{
            // chú ý --> (0)+(0|3|5|7|8|9)+([0-9]{8}) khác AuthorizationService
            let PHONE_REGEX = "^(0)+(0|3|5|7|8|9)+([0-9]{8})$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            result =  phoneTest.evaluate(with: phone)
        }
        return result
    }
    
    func ValidationOTP(_ otp:String?) -> Bool {
        var result = false
        if otp != nil{
            let PHONE_REGEX = "^([0-9]{6})$"
            let otpTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            result =  otpTest.evaluate(with: otp)
        }
        return result
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


