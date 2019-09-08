//
//  TableUtils.swift
//  orderProject2
//
//  Created by Phu Vu on 9/6/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import Foundation

class TableUtils {
    var tableItemList = [TableItem]()
    
    func dumpData() {
        let floor0Table1 = TableItem(floorCode: 0, tableName: "A0-001", tableImage: "TwoSeatsTable")
        let floor0Table2 = TableItem(floorCode: 0, tableName: "A0-002", tableImage: "TwoSeatsTable")
        let floor0Table3 = TableItem(floorCode: 0, tableName: "A0-003", tableImage: "TwoSeatsTable")
        tableItemList.append(floor0Table1)
        tableItemList.append(floor0Table2)
        tableItemList.append(floor0Table3)
        
        let floor1Table1 = TableItem(floorCode: 1, tableName: "A1-001", tableImage: "TwoSeatsTable")
        let floor1Table2 = TableItem(floorCode: 1, tableName: "A1-002", tableImage: "TwoSeatsTable")
        let floor1Table3 = TableItem(floorCode: 1, tableName: "A1-003", tableImage: "TwoSeatsTable")
        tableItemList.append(floor1Table1)
        tableItemList.append(floor1Table2)
        tableItemList.append(floor1Table3)
        
        let floor2Table1 = TableItem(floorCode: 2, tableName: "A2-001", tableImage: "FourSeatsTable")
        let floor2Table2 = TableItem(floorCode: 2, tableName: "A2-002", tableImage: "FourSeatsTable")
        let floor2Table3 = TableItem(floorCode: 2, tableName: "A2-003", tableImage: "FourSeatsTable")
        tableItemList.append(floor2Table1)
        tableItemList.append(floor2Table2)
        tableItemList.append(floor2Table3)
        
        let floor3Table1 = TableItem(floorCode: 3, tableName: "A3-001", tableImage: "FourSeatsTable")
        let floor3Table2 = TableItem(floorCode: 3, tableName: "A2-002", tableImage: "FourSeatsTable")
        let floor3Table3 = TableItem(floorCode: 3, tableName: "A2-003", tableImage: "FourSeatsTable")
        tableItemList.append(floor3Table1)
        tableItemList.append(floor3Table2)
        tableItemList.append(floor3Table3)
    }
    
    func printTableItemList() {
        for index in 0...tableItemList.count - 1 {
            print(tableItemList[index].floorCode)
        }
    }
    
    func searchFloor(floorCodeInput: Int) -> [TableItem]{
        var tempTableList = [TableItem]()
        for index in 0...tableItemList.count - 1 {
            if tableItemList[index].floorCode == floorCodeInput {
                tempTableList.append(tableItemList[index])
            }
        }
        return tempTableList
    }
   
}
