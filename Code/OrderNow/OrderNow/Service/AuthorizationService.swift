//
//  AuthorizationService.swift
//  OrderNow
//
//  Created by ADMIN on 9/7/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class AuthorizationService {
    static let host = "http://13.229.117.90:8012/Auth/"
    
    static func Login(phoneNumber:String, otp:String, completion:  @escaping (_ status: Bool, _ error: Error?) -> Void ) -> Void {
        let url = "\(host)Login"
        if let urlLogin = URL(string: url){
            var urlRequest = URLRequest(url: urlLogin)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let jsonDangNhap : [String: Any] = [
                "Username": "\(phoneNumber)",
                "Pwd": "\(otp)",
                "Token": "",
                "AccountType": "Thuong",
                "Email": "\(phoneNumber)",
            ]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonDangNhap, options: [])
            urlRequest.httpBody = jsonData
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest){data,response,error in
                guard error == nil else {
                    completion(false,error)
                    return
                }
                guard let dataResponce = data else {
                    completion(false,error)
                    return
                }
                
                let loginJson = try? JSONSerialization.jsonObject(with: dataResponce, options: []) as? [String:Any]
                if(loginJson != nil){
                    let status = loginJson!["Status"] as? Int
                    if(status != nil && status == 1) {
                        // login thanh cong
                        completion(true,nil)
                    } else{
                        completion(false,nil)
                    }
                }
                
            }
            task.resume()
        }
    }
}
