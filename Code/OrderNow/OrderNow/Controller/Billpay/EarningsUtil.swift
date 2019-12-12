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
}
