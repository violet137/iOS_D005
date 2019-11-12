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

class EarningUtil {
    var Earningref: DatabaseReference!
    var earningList = [EarningsModel]()
    var delegateEarning: delegateEarning?

    func getPay(/*orderList: [MonAnBill], time: Date, tableId: String, total: Int*/){
        self.Earningref = Database.database().reference().root
        self.Earningref.observeSingleEvent(of: .value) { (snapshot) in
            for item in snapshot.children.allObjects {
                let snap = item as! DataSnapshot
                let check = snap.hasChild("Earnings")
                if !check {
                    print("have data name Earnings")
                } else {
                    print("Have not data name Earnings")
                }
            }
            self.delegateEarning?.EarningUpdateData()
        }
    }
}
