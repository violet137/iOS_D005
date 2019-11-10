//
//  BookingBeforeUtils.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 11/1/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import Firebase

protocol sentDataTo{
    
    func onDataUpdate()
}

class BookingBeforeUtils{
    var listBooking = [BookBefore]()
    var ref: DatabaseReference!
    var delegate: sentDataTo?
    
    func getDataFromDataBase(){
        ref = Database.database().reference()
        ref.child("DatTruoc").observeSingleEvent(of: .value, with: { (snapshot) in
            self.listBooking.removeAll()
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let ten = dict["ten_kh"] as? String
                let tgden = dict["thoi_gian_den"] as? String
                let ngay = dict["ngay"] as? String
                let songuoi = dict["so_nguoi"] as? Int
                let gmail = dict["gmail"] as? String
                let message = dict["message"] as? String
                let list = BookBefore(ten: ten!, thoigian: tgden!, songuoi: songuoi!, gmail: gmail!, message: message!, ngay: ngay!)
                self.listBooking.append(list)
        
            }
            self.sapXepList()
            self.delegate?.onDataUpdate()
        }) { (Error) in
            print(Error.localizedDescription)
        }
    }
    
    func sapXepList(){
        
    }
    
}
