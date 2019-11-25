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

class EarningUtil:NSObject {
    var ref: DatabaseReference!
    var earningList = [EarningsModel]()
    var earning: EarningsModel?
    var delegateEarning: delegateEarning?

    func getPay(){
        self.ref = Database.database().reference()
        let montemp1 = MonAnBill(monID: "2", gia: 20000, hinh: "2", soLuong: 1, ten: "An vat")
        let montemp2 = MonAnBill(monID: "3", gia: 25000, hinh: "3", soLuong: 1, ten: "An vat")
        var monData = [MonAnBill]()
        monData.append(montemp1)
        monData.append(montemp2)
        let billPayTemp = BillPay(banID: monData, banName: "2")
        var billPayData = [BillPay]()
        billPayData.append(billPayTemp)
        
        let earningTemp = EarningsModel(billPay: billPayData, time: "12/11/2019", total: 20000, staff: "Anh")
        var dataToFirebase = [EarningsModel]()
        self.earningList.append(earningTemp)
        let earningsRef = self.ref.child("Earnings")
    
        earningsRef.childByAutoId().setValue(earningTemp.toDictionary())
        earningsRef.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children {
                for grandchild in snapshot.children{
                    let item = grandchild as! DataSnapshot
                    let key = item.key
                    if billPayData.count != 0 {
                        for bill in billPayData {
                            let billRef = earningsRef.child(bill.banName!)
                            earningsRef.child(key).child(bill.banName!).setValue(billPayTemp.billPayToDict())
                            if monData.count != 0 {
                                for mon in monData {
                                    let temp = MonAnBill(monID: mon.monID!, gia: mon.gia!, hinh: mon.hinh!, soLuong: mon.soLuong!, ten: mon.ten!)
                                    earningsRef.child(key).child(bill.banName!).child(mon.monID!).setValue(temp.monAnToDict())
                                }
                            }
                        }
                    }
                }
            }
        }
        
        
//        self.Earningref.child("Earnings").childByAutoId().setValue(["monID" : dataEarningList.monID!, "gia" : dataEarningList.gia!, "hinh" : dataEarningList.hinh!, "tenmon" : dataEarningList.tenmon!, "time" : dataEarningList.time!, "total" : dataEarningList.total!, "staff" : dataEarningList.staff!])
//            self.Earningref.observeSingleEvent(of: .value) { (snapshot) in
//                for item in snapshot.children.allObjects {
//                    let snap = item as! DataSnapshot
//                    let check = snap.hasChild("Earnings")
//                    let currentDate = Date()
//                    let timeFormatter = DateFormatter()
//                    timeFormatter.dateFormat = "dd-MM-yyyy"
//                    let timedata = timeFormatter.string(from: currentDate)
//                    //
//                    let childref = snap.childSnapshot(forPath: "Earnings")
//                    if (check == false) {
//                        //                    self.Earningref.child("Earnings").setValue(dataFirebase)
//                        //                    self.Earningref.child("Earnings").setValue(datansarr)
//                        print("have data name Earnings")
//                    } else {
//                        print("Have not data name Earnings")
//                    }
//                }
        self.delegateEarning?.EarningUpdateData()
    }
}
