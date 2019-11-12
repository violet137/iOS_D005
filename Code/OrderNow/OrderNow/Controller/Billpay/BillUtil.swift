//
//  BillUtil.swift
//  
//
//  Created by admin on 9/21/19.
//

import Foundation
import Firebase
import FirebaseDatabase

protocol sentData {
    func updataData()
}

class BillUtil: dataPassBillDelegate {
    func getTable(statusCode: Int, ID: Int) {
        self.statusCode = statusCode
        self.tableID = ID
    }
    
    var tableDelegate: TableCallback?
    var delegate: sentData?
    
    var tableList = [TableItem]()
    var list = [MonAnBill]()
    var billList = [BillPay]()
    var ref: DatabaseReference!
    var statusCode: Int?
    var tableID: Int?
    
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
            print(self.tableID)
            print(self.statusCode)
            self.delegate?.updataData()
        }
    }
    
    func filterBill (ban: String) -> [MonAnBill] {
        var result = [MonAnBill]()
        if (self.billList.count != 0) {
            for item in self.billList {
//                let table = tableUtil.getSelectedTable(selectedTable: Int(ban)!)
//                if ((item.banName == ban) && (table != nil)) {
//                    result.append(contentsOf: item.banID!)
//                }
            }
            self.delegate?.updataData()
        }
        return result
    }
}
