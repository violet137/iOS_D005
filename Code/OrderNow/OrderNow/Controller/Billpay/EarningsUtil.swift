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
                if (snap.hasChildren() == true) {
                    snap.setNilValueForKey("Earnings")
                }
            }
            self.delegateEarning?.EarningUpdateData()
        }
    }
}
