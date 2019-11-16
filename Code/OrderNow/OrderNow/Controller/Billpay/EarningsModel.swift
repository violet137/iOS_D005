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
    var time: Date?
    var tableID: String?
    var total: Int?
    
    init(billPay: [BillPay], time: Date, tableId: String, total: Int) {
        self.billPay = billPay
        self.time = time
        self.tableID = tableId
        self.total = total
    }
}
