//
//  BillModal.swift
//  OrderNow
//
//  Created by admin on 9/21/19.
//  Copyright © 2019 ForLearn. All rights reserved.
//

import Foundation

class MonAn {
    var monID: String?
    var gia: Int?
    var hinh: String?
    var loai: Int?
    var ten: String?
    
    init(monID: String, gia: Int, hinh: String, loai: Int, ten: String) {
        self.monID = monID
        self.gia = gia
        self.hinh = hinh
        self.loai = loai
        self.ten = ten
    }
}
