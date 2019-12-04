//
//  EarningsModel.swift
//  OrderNow
//
//  Created by admin on 10/23/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import Foundation

class EarningsModel {
    
    var billPay: [BillPay]?
    var time: String?
    var total: Int?
    var staff: String?
    
    init(billPay: [BillPay], time: String, total: Int?, staff: String) {
        self.billPay = billPay
        self.time = time
        self.total = total
        self.staff = staff
    }
}
extension EarningsModel {
    func toDictionary() -> Any{
        return [
            "time": time,
            "total": total,
            "staff": staff,
        ]
    }
}
