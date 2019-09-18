//
//  BookingService.swift
//  OrderNow
//
//  Created by ADMIN on 9/18/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import Firebase

class BookingService {
    var refDataFirebase : DatabaseReference!
    
    init() {
        refDataFirebase = Database.database().reference()
    }
    
    func SetStatusTable(id:String) -> Void {
        refDataFirebase.child("table-items").child(id).updateChildValues(["status" : 1])
    }
    
    func GetDetailTable(id:String, completion:  @escaping (_ status: Bool,_ data: DetailTableOutput? , _ error: Error?) -> Void ) -> Void {
        refDataFirebase.child("table-items").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get value
            let value = snapshot.value as? NSDictionary
            
            let chairs = value?["chairs"] as? Int ?? -1
            let floor = value?["floor"] as? Int ?? -1
            let image = value?["image"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            let status = value?["status"] as? Int ?? -1
            
            completion(true,DetailTableOutput(chairs,floor,image,name,status),nil)
            
        }) { (error) in
            completion(false,nil,error)
        }
    }
}
