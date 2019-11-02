//
//  EarningsModel.swift
//  OrderNow
//
//  Created by admin on 10/23/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import Foundation

class EarningsModel {
    var monAnBill: [MonAnBill]?
    var time: Date?
    var tableID: String?
    var total: Int?
    
    init(monAnBill: [MonAnBill], time: Date, tableId: String, total: Int) {
        self.monAnBill = monAnBill
        self.time = time
        self.tableID = tableId
        self.total = total
    }
}
