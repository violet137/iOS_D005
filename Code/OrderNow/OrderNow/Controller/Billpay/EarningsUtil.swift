//
//  EarningsUtil.swift
//  OrderNow
//
//  Created by admin on 10/23/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import Foundation
import Firebase

protocol delegateEarning {
    func EarningUpdateData()
}

protocol delegateGetDataEarning {
    func getDataFromEarning()
}

class EarningUtil {
    var ref: DatabaseReference!
    var earningList = [EarningsModel]()
    var earningTotalList = [EarningsModel]()
    var earning: EarningsModel?
    var billList = [BillPay]()
    var monanList = [MonAnBill]()
    var delegateEarning: delegateEarning?
    var delegateGetDataEarning: delegateGetDataEarning?

    func getPay(billPay: [BillPay], total: Int, user: String){
        self.ref = Database.database().reference()
        let billPayTemp = BillPay(banID: billPay[0].banID!, banName: billPay[0].banName!)
        var billPayData = [BillPay]()
        billPayData.append(billPayTemp)
        let currentDate = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm dd-MM-yyyy"
        let timedata = timeFormatter.string(from: currentDate)
        let earningTemp = EarningsModel(billPay: billPayData, time: timedata, total: total, staff: user)
        let earningsRef = self.ref.child("Earnings")
        let keyban = earningsRef.childByAutoId().key
        earningsRef.child(keyban!).observeSingleEvent(of: .value) { (DataSnapshot) in
            earningsRef.child(keyban!).setValue(earningTemp.toDictionary())
            if billPayData.count != 0 {
                for bill in billPayData {
                    if billPay[0].banID!.count != 0 {
                        for mon in billPay[0].banID! {
                            let temp = MonAnBill(monID: mon.monID!, gia: mon.gia!, hinh: mon.hinh!, soLuong: mon.soLuong!, ten: mon.ten!)
                            earningsRef.child(keyban!).child(bill.banName!).child(mon.monID!).setValue(temp.monAnToDict())
                        }
                    }
                }
            }
        }
        self.delegateEarning?.EarningUpdateData()
    }
    
    func getEarningData () {
        self.ref = Database.database().reference()
        self.ref.child("Earnings").observeSingleEvent(of: .value) { (Snapshot) in
            self.earningTotalList.removeAll()
            
            for fatherItem in Snapshot.children {
                let snap = fatherItem as! DataSnapshot
                let fatherDict = snap.value as! NSDictionary
                let childRef = Snapshot.childSnapshot(forPath: snap.key)
                var tempBill = [BillPay]()
                for item in childRef.children {
                    let childSnap = item as! DataSnapshot
                    
                    if childSnap.hasChildren() {
                        let grandChildRef = snap.childSnapshot(forPath: childSnap.key)
                        var tempMonAn = [MonAnBill]()
                        for childItem in grandChildRef.children {
                            let grandChildSnap = childItem as! DataSnapshot
                            let childDict = grandChildSnap.value as! NSDictionary
                            let ten = childDict["ten"] as? String
                            let gia = childDict["gia"] as? Int
                            let hinh = childDict["hinh"] as? String
                            let soLuong = childDict["soLuong"] as? Int
                            let monID = grandChildSnap.key
                            let mon = MonAnBill(monID: monID, gia: gia!, hinh: hinh!, soLuong: soLuong!, ten: ten!)
                            tempMonAn.append(mon)
                        }
                        let bill = BillPay(banID: tempMonAn, banName: childSnap.key)
                        tempBill.append(bill)
                    }
                }
                let staff = fatherDict["staff"] as! String
                let time = fatherDict["time"] as! String
                let total = fatherDict["total"] as! Int
                let tempEarnings = EarningsModel(billPay: tempBill, time: time, total: total, staff: staff)
                self.earningTotalList.append(tempEarnings)
            }
            self.delegateGetDataEarning?.getDataFromEarning()
        }
        
    }
}
