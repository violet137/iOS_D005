//
//  LoginController.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 8/28/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import GoogleSignIn

protocol sentUserInfo: class {
    func sentData(user: GIDGoogleUser)
}

class LoginController: UIViewController, GIDSignInDelegate {
    
    weak var delegate: sentUserInfo?
    
    var user : GIDGoogleUser?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            return
        }
        present(HomePageController(), animated: false, completion: nil)
        delegate?.sentData(user: user)
        self.user = user
        //        let alert = UIAlertController()
        //        alert.title = user.profile.name
        //        alert.message = user.profile.email
        //        alert.addAction(UIAlertAction(title: "done", style: .cancel, handler: { (action) in
        //            self.dismiss(animated: false, completion: nil)
        //        }))
        //        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @IBAction func loginAct(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
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
