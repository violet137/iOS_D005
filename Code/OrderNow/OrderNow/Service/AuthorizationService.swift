//
//  AuthorizationService.swift
//  OrderNow
//
//  Created by ADMIN on 9/7/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import Firebase

class AuthorizationService {
    static let host = "http://13.229.117.90:8012/Auth/"
    
    var refDataFirebase : DatabaseReference!
    
    init() {
        refDataFirebase = Database.database().reference()
    }
    
    func Register(phoneNumber:String) -> Void {
        let otp = randomString(6)
        refDataFirebase.child("userList").child(phoneNumber)
            .setValue([
                "userName": "Dev",
                "phone": "\(phoneNumber)",
                "type": "\(ValidationPhoneNumber(phoneNumber) ? 1 : 2)",
                "code": "\(otp)"
                ])
        
        print("OTP: \(otp) <---------------------------")
    }
    
    func ValidationPhoneNumber(_ phone:String?) -> Bool {
        var result = false
        if phone != nil{
            // chú ý --> (0)+(3|5|7|8|9)+([0-9]{8}) khác LoginViewController
            let PHONE_REGEX = "^(0)+(3|5|7|8|9)+([0-9]{8})$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            result =  phoneTest.evaluate(with: phone)
        }
        return result
    }
    
    func randomString(_ length: Int) -> String {
        let letters = "0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func Login(phoneNumber:String, otp:String, completion:  @escaping (_ status: Bool,_ data: LoginOutput? , _ error: Error?) -> Void ) -> Void {
        refDataFirebase.child("userList").child(phoneNumber).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let code = value?["code"] as? String ?? ""
            let type = value?["type"] as? String ?? ""
            if(otp == code){
                let userName = value?["userName"] as? String ?? ""
                completion(true,LoginOutput(userName: userName,typeAcc: type),nil)
            }else{
                let domain = ""
                let code = -1
                let info = [NSLocalizedDescriptionKey: """
                    Mã OTP không chính xác.
                    Vui lòng kiểm tra lại.
                    """]
                let error = NSError(domain: domain, code: code, userInfo: info)

                completion(false,nil,error)
            }
        }) { (error) in
            completion(false,nil,error)
        }
    }
}
