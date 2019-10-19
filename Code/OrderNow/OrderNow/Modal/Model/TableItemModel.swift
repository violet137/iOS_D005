//
//  Model.swift
//  orderProject2
//
//  Created by Phu Vu on 9/6/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import Foundation

class TableItem{
    var floorCode: Int?
    var tableCode: Int?
    var tableName: String?
    var tableImage: String?
    var statusOfTable: Int?
    var numberOfPeople: Int?
    var numberOfChair: Int?
    
    init(floorCode: Int, tableCode: Int, tableName: String, tableImage: String, statusOfTable: Int, numberOfPeople: Int,  numberOfChair: Int) {
        self.floorCode = floorCode
        self.tableCode = tableCode
        self.tableName = tableName
        self.tableImage = tableImage
        self.statusOfTable = statusOfTable
        self.numberOfPeople = numberOfPeople
        self.numberOfChair = numberOfChair
    }
    
}
