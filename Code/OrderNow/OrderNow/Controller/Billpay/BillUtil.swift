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
    var list = [MonAnBill]()
    var billList = [BillPay]()
    var ref: DatabaseReference!
    var delegate: sentData?
    
//    func dumpData(){
//        ref = Database.database().reference()
//        ref.child("MonAn").observeSingleEvent(of: .value, with: { (snapshot) in
//            self.list.removeAll()
//            for item in snapshot.children {
//                let snap = item as! DataSnapshot
//                let dict = snap.value as! NSDictionary
//                
//                let gia = dict["gia"] as? Int
//                let hinh = dict["hinh"] as? String
//                let loai = dict["loai"] as? Int
//                let ten = dict["ten"] as? String
//                let monanItem = MonAnBill(monID: String(snap.key), gia: gia!, hinh: hinh!, soLuong:  loai!, ten: ten!)
//                self.list.append(monanItem)
//            }
//            self.delegate?.updataData()
//        }) { error in
//            print(error.localizedDescription)
//        }
//    }
    
    func getOrderList() {
        self.ref = Database.database().reference()
        self.ref.child("ListOrder").observeSingleEvent(of: .value) { (snapshot) in
            self.billList.removeAll()
            
            for item in snapshot.children.allObjects {
                let snap = item as! DataSnapshot
                let childRef = snapshot.childSnapshot(forPath: snap.key)
                var tempList = [MonAnBill]()
                for childItem in childRef.children {
                    let childSnap = childItem as! DataSnapshot
                    let dict = childSnap.value as! NSDictionary
                    let ten = dict["name"] as? String
                    let gia = dict["gia1Mon"] as? Int
                    let hinh = dict["hinh"] as? String
                    let soLuong = dict["soLuong"] as? Int
                    let monID = childSnap.key
                    let mon = MonAnBill(monID: monID, gia: gia!, hinh: hinh!, soLuong: soLuong!, ten: ten!)
                    tempList.append(mon)
                }// End of for childItem
                let temBill = BillPay(banID: tempList, banName: snap.key)
                self.billList.append(temBill)
            }// End of for item
            self.delegate?.updataData()
        }
    }
    
    func filterBill (ban: String) -> [MonAnBill]{
        var billfilter = [MonAnBill]()
        if (billList.count > 0) {
            for item in billList {
                if item.banName == ban {
                    billfilter.append(contentsOf: item.banID!)
                }
            }
        }
        return billfilter
    }
}
