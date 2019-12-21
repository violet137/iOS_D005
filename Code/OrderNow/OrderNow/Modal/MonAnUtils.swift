//
//  ListMonAnUtils.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 9/17/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

protocol sentDataToList{
    
    func onDataUpdate()
}

class MonAnUtils{
    
    var listMon = [MonAn]()
    var ref: DatabaseReference!
    var delegate: sentDataToList?
    
    func getDataFromFireBase(){
        ref = Database.database().reference()
        ref.child("MonAn").observeSingleEvent(of: .value, with: { (snapshot) in
            self.listMon.removeAll()
            
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let ten = dict["ten"] as? String
                let gia = dict["gia"] as? Double
                let loai = dict["loai"] as? Int
                let hinh = dict["hinh"] as? String
                
                let list = MonAn(ten: ten!, loai: loai!, gia: gia!, hinh: hinh!)
                self.listMon.append(list)
                print(item)
            }
            
            self.delegate?.onDataUpdate()
            
        }) { error in
            print(error.localizedDescription)
        }
    }
    
    func FilterListMonAn(loai: Int) -> [MonAn]{
        var list = [MonAn]()
        if(listMon.count > 0){
            for mon in listMon{
                if mon.loaiMonAn == loai{
                    list.append(mon)
                }
            }
        }
        return list
    }
    
    func removeOrder(banid: String) {
        ref = Database.database().reference()
        ref.child("ListOrder").child(banid).removeValue()
        getDataFromFireBase()
    }
    
    
}
