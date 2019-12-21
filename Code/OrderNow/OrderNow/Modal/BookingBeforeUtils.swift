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

protocol sentDataQueryOrderd {
    func updateData()
}

class BookingBeforeUtils{
    var listBooking = [BookBefore]()
    var listProgress = [BookBefore]()
    var listDone = [BookBefore]()
    var ref: DatabaseReference!
    var delegate: sentDataTo?
    
    func getDataFromDataBase(){
        ref = Database.database().reference()
        
        ref.child("DatTruoc").queryOrdered(byChild: "thoi_gian_den").observeSingleEvent(of: .value, with: { (snapshot) in
            self.listBooking.removeAll()
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let idDonHang = snap.key
                let sdt = dict["ten_kh"] as? String
                let tgden = dict["thoi_gian_den"] as? String
                
                let songuoi = dict["so_nguoi"] as? Int
                let status = dict["status"] as? Int
                
                let message = dict["message"] as? String
                let list = BookBefore(sdt: sdt!, thoigian: tgden!, songuoi: songuoi!, message: message!, user: "", stt: status!, id: idDonHang)
                self.listBooking.append(list)
                if list.status! == 0{
                    self.listDone.append(list)
                }else{
                    self.listProgress.append(list)
                }
            }
            self.sapXepList()
            self.delegate?.onDataUpdate()
        }) { (Error) in
            print(Error.localizedDescription)
        }
    }
    
    func sapXepList(){
        let formmater = DateFormatter()
        formmater.dateFormat = "yyyy/MM/dd-HH:mm"
        let currentDate = formmater.string(from: Date())
        for i in 0..<listBooking.count{
            if listBooking[i].thoiGianDen! < currentDate{
                let data = listBooking[i]
                listBooking.remove(at: i)
                listBooking.append(data)
            }
        }
    }
    
}
