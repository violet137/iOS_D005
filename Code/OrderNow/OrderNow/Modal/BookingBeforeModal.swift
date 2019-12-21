//
//  BookingBefore.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 11/1/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
class BookBefore{
    
    var soDT: String?
    var thoiGianDen: String?
    var soNguoi: Int?
    var idDonHang: String?
    var message: String?
    var userBook: String?
    var status: Int?
    
    init(sdt: String, thoigian: String, songuoi: Int, message: String, user: String, stt: Int, id: String) {
        self.soDT = sdt
        self.thoiGianDen = thoigian
        self.soNguoi = songuoi
        self.message = message
        self.userBook = user
        self.status = stt
        self.idDonHang = id
    }
    
}
