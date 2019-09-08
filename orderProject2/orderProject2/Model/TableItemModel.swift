//
//  Model.swift
//  orderProject2
//
//  Created by Phu Vu on 9/6/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import Foundation

class TableItem{
    var floorCode: Int = 0
    var tableName: String = ""
    var tableImage: String = ""
    
    init(floorCode: Int, tableName: String, tableImage: String) {
        self.floorCode = floorCode
        self.tableImage = tableName
        self.tableImage = tableImage
    }
    
}
