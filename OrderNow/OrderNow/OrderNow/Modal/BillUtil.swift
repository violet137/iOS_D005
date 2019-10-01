//
//  BillUtil.swift
//  
//
//  Created by admin on 9/21/19.
//

import Foundation
import Firebase

protocol sentData {
    func updataData()
}

class BillUtil {
    var list = [MonAn]()
    var ref: DatabaseReference!
    var delegate: sentData?
    
    func dumpData(){
        ref = Database.database().reference()
        ref.child("MonAn").observeSingleEvent(of: .value, with: { (snapshot) in
            self.list.removeAll()
            for item in snapshot.children {
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let gia = dict["gia"] as? Int
                let hinh = dict["hinh"] as? String
                let loai = dict["loai"] as? Int
                let ten = dict["ten"] as? String
                let monanItem = MonAn(monID: String(snap.key), gia: gia!, hinh: hinh!, loai: loai!, ten: ten!)
                self.list.append(monanItem)
            }
            self.delegate?.updataData()
        }) {(error) in
            print(error.localizedDescription)
        }
    }
}
