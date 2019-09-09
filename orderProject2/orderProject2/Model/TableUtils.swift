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
        let floor0Table4 = TableItem(floorCode: 0, tableName: "A0-004", tableImage: "FourSeatsTable")
        let floor0Table5 = TableItem(floorCode: 0, tableName: "A0-005", tableImage: "FourSeatsTable")
        let floor0Table6 = TableItem(floorCode: 0, tableName: "A0-006", tableImage: "FourSeatsTable")
        let floor0Table7 = TableItem(floorCode: 0, tableName: "A0-007", tableImage: "SixSeatsTable")
        let floor0Table8 = TableItem(floorCode: 0, tableName: "A0-008", tableImage: "SixSeatsTable")
        let floor0Table9 = TableItem(floorCode: 0, tableName: "A0-009", tableImage: "SixSeatsTable")
        let floor0Table10 = TableItem(floorCode: 0, tableName: "A0-010", tableImage: "TwoSeatsTable")
        let floor0Table11 = TableItem(floorCode: 0, tableName: "A0-011", tableImage: "TwoSeatsTable")
        let floor0Table12 = TableItem(floorCode: 0, tableName: "A0-012", tableImage: "TwoSeatsTable")
        tableItemList.append(floor0Table1)
        tableItemList.append(floor0Table2)
        tableItemList.append(floor0Table3)
        tableItemList.append(floor0Table4)
        tableItemList.append(floor0Table5)
        tableItemList.append(floor0Table6)
        tableItemList.append(floor0Table7)
        tableItemList.append(floor0Table8)
        tableItemList.append(floor0Table9)
        tableItemList.append(floor0Table10)
        tableItemList.append(floor0Table11)
        tableItemList.append(floor0Table12)
        
        
        let floor1Table1 = TableItem(floorCode: 1, tableName: "A1-001", tableImage: "TwoSeatsTable")
        let floor1Table2 = TableItem(floorCode: 1, tableName: "A1-002", tableImage: "TwoSeatsTable")
        let floor1Table3 = TableItem(floorCode: 1, tableName: "A1-003", tableImage: "TwoSeatsTable")
        let floor1Table4 = TableItem(floorCode: 1, tableName: "A1-004", tableImage: "TwoSeatsTable")
        let floor1Table5 = TableItem(floorCode: 1, tableName: "A1-005", tableImage: "TwoSeatsTable")
        let floor1Table6 = TableItem(floorCode: 1, tableName: "A1-006", tableImage: "TwoSeatsTable")
        let floor1Table7 = TableItem(floorCode: 1, tableName: "A1-007", tableImage: "FourSeatsTable")
        let floor1Table8 = TableItem(floorCode: 1, tableName: "A1-008", tableImage: "FourSeatsTable")
        let floor1Table9 = TableItem(floorCode: 1, tableName: "A1-009", tableImage: "FourSeatsTable")
        let floor1Table10 = TableItem(floorCode: 1, tableName: "A1-007", tableImage: "SixSeatsTable")
        let floor1Table11 = TableItem(floorCode: 1, tableName: "A1-008", tableImage: "SixSeatsTable")
        let floor1Table12 = TableItem(floorCode: 1, tableName: "A1-009", tableImage: "SixSeatsTable")
        tableItemList.append(floor1Table1)
        tableItemList.append(floor1Table2)
        tableItemList.append(floor1Table3)
        tableItemList.append(floor1Table4)
        tableItemList.append(floor1Table5)
        tableItemList.append(floor1Table6)
        tableItemList.append(floor1Table7)
        tableItemList.append(floor1Table8)
        tableItemList.append(floor1Table9)
        
        
        
        
        let floor2Table1 = TableItem(floorCode: 2, tableName: "A2-001", tableImage: "FourSeatsTable")
        let floor2Table2 = TableItem(floorCode: 2, tableName: "A2-002", tableImage: "FourSeatsTable")
        let floor2Table3 = TableItem(floorCode: 2, tableName: "A2-003", tableImage: "FourSeatsTable")
        tableItemList.append(floor2Table1)
        tableItemList.append(floor2Table2)
        tableItemList.append(floor2Table3)
        
        let floor3Table1 = TableItem(floorCode: 3, tableName: "A3-001", tableImage: "FourSeatsTable")
        let floor3Table2 = TableItem(floorCode: 3, tableName: "A3-002", tableImage: "FourSeatsTable")
        let floor3Table3 = TableItem(floorCode: 3, tableName: "A3-003", tableImage: "FourSeatsTable")
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
