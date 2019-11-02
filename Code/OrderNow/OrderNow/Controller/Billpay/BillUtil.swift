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

class BillUtil: TableCallback{
    func onDataUpdate() {
        self.tableUtil.dumpData()
        self.tableUtil.tableListening(callback: self)
    }
    
    func choXacNhan(ban: TableItem) {
        
    }
    
    var tableDelegate: TableCallback?
    var tableUtil = TableUtils()
    var tableList = [TableItem]()
    var list = [MonAnBill]()
    var billList = [BillPay]()
    var ref: DatabaseReference!
    var delegate: sentData?
    var tableItem = TableUtils()
    
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
