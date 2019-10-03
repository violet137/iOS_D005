//
//  BillModal.swift
//  OrderNow
//
//  Created by admin on 9/21/19.
//  Copyright © 2019 ForLearn. All rights reserved.
//

import Foundation

class MonAnBill {
    var monID: String?
    var gia: Int?
    var hinh: String?
    var soLuong: Int?
    var ten: String?
    
    init(monID: String, gia: Int, hinh: String, soLuong: Int, ten: String) {
        self.monID = monID
        self.gia = gia
        self.hinh = hinh
        self.soLuong = soLuong
        self.ten = ten
    }
}

class BillPay {
    var banName: String?
    var banID: [MonAnBill]?
    init(banID: [MonAnBill], banName: String) {
        self.banID = banID
        self.banName = banName
    }
}
