//
//  ListMonAnModal.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 9/17/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class MonAn{
    
    var tenMonAn: String?
    var loaiMonAn: Int?
    var giaTien: Double?
    var hinh: String?
    
    init(ten:String, loai: Int, gia: Double, hinh: String) {
        self.tenMonAn = ten
        self.loaiMonAn = loai
        self.giaTien = gia
        self.hinh = hinh
    }
}
