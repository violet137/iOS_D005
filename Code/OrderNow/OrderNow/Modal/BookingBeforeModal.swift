//
//  BookingBefore.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 11/1/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
class BookBefore{
    
    var tenKH: String?
    var thoiGianDen: String?
    var ngay: String?
    var soNguoi: Int?
    var gmail: String?
    var message: String?
    
    init(ten: String, thoigian: String, songuoi: Int, gmail: String, message: String, ngay: String) {
        self.tenKH = ten
        self.thoiGianDen = thoigian
        self.soNguoi = songuoi
        self.gmail = gmail
        self.message = message
        self.ngay = ngay
    }
    
}
