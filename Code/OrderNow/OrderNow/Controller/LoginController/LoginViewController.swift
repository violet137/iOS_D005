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
        var alert = UIAlertController();
        alert.title = "test"
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
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
