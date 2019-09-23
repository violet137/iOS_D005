//
//  OderModal.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 9/17/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import Foundation

class OrderModal{
    
    var tenMon: String?
    var soLuongDat: Int?
    var hinh: String?
    var gia1Mon: Double?
    var maBan: String?
    
    init(ten: String, soluong: Int, hinh: String, gia1Mon: Double) {
        self.tenMon = ten
        self.soLuongDat = soluong
        self.hinh = hinh
        self.gia1Mon = gia1Mon
    }
    
}
