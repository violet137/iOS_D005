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
                let monanItem = MonAnBill(monID: String(snap.key), gia: gia!, hinh: hinh!, soLuong:  loai!, ten: ten!)
                self.list.append(monanItem)
            }
            self.delegate?.updataData()
        }) {(error) in
            print(error.localizedDescription)
        }
    }
    
    func getOrderList() {
        ref = Database.database().reference()
        ref.child("ListOrder").observeSingleEvent(of: .value) { (snapshot) in
            self.billList.removeAll()
            
            for item in snapshot.children {
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                let banName = snap.key as? String
                let refItem = self.ref.child("ListOrder/\(snap.key)")
                refItem.observeSingleEvent(of: .value, with: { (snapshotItem) in
                    for inerItem in snapshotItem.children {
                        let snapdata = inerItem as! DataSnapshot
                        let inerDict = snapdata.value as! NSDictionary
                        
                        let gia = inerDict["gia1Mon"] as? Int
                        let hinh = inerDict["hinh"] as? String
                        let soLuong = inerDict["soLuong"] as? Int
                        let ten = inerDict["name"] as? String
                        let mon = MonAnBill(monID: snapdata.key, gia: gia!, hinh: hinh!, soLuong: soLuong!, ten: ten!)
                        self.list.append(mon)
                    }//end for inerItem
                    let billPay = BillPay.init(banID: self.list, banName: banName!)
                    self.billList.append(billPay)
                })
            }//end for item
            self.delegate?.updataData()
        }
    }
}
