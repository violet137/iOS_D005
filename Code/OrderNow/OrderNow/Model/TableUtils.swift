//
//  TableUtils.swift
//  orderProject2
//
//  Created by Phu Vu on 9/6/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol TableCallback {
    func onDataUpdate()
}


class TableUtils {
    var tableItemList = [TableItem]()
    
    var ref: DatabaseReference!
    
    var callback:TableCallback?
    
    func tableListening(callback:TableCallback)  {
        self.callback = callback
        ref.child("table-items").observe(.childChanged) { (snapshot) in
            self.dumpData()
        }
    }
    
    func dumpData() {
        ref = Database.database().reference()
        ref.child("table-items").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get table value
            self.tableItemList.removeAll()
            for item in snapshot.children {
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let floor = dict["floor"] as? Int
                let image =  dict["image"] as? String
                let name =  dict["name"] as? String
                let chairs =  dict["chairs"] as? Int
                let status =  dict["status"] as? Int
                let table = TableItem(floorCode: floor!, tableCode: Int(snap.key)!, tableName:name!, tableImage: image!, statusOfTable: status!, numberOfChair: chairs!)
                self.tableItemList.append(table)
                //print("ban: \(item)")
            }
            self.callback?.onDataUpdate()
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //        let floor0Table1 = TableItem(floorCode: 0, tableCode: 1, tableName: "A0-001", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor0Table2 = TableItem(floorCode: 0, tableCode: 2, tableName: "A0-002", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor0Table3 = TableItem(floorCode: 0, tableCode: 3, tableName: "A0-003", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor0Table4 = TableItem(floorCode: 0, tableCode: 4, tableName: "A0-004", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor0Table5 = TableItem(floorCode: 0, tableCode: 5, tableName: "A0-005", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor0Table6 = TableItem(floorCode: 0, tableCode: 6, tableName: "A0-006", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor0Table7 = TableItem(floorCode: 0, tableCode: 7, tableName: "A0-007", tableImage: "SixSeatsTable", statusOfTable: false, numberOfChair: 6)
        //        let floor0Table8 = TableItem(floorCode: 0, tableCode: 8, tableName: "A0-008", tableImage: "SixSeatsTable", statusOfTable: false, numberOfChair: 6)
        //        let floor0Table9 = TableItem(floorCode: 0, tableCode: 9, tableName: "A0-009", tableImage: "SixSeatsTable", statusOfTable: false, numberOfChair: 6)
        //        let floor0Table10 = TableItem(floorCode: 0, tableCode: 10, tableName: "A0-010", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor0Table11 = TableItem(floorCode: 0, tableCode: 11, tableName: "A0-011", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor0Table12 = TableItem(floorCode: 0, tableCode: 12, tableName: "A0-012", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        tableItemList.append(floor0Table1)
        //        tableItemList.append(floor0Table2)
        //        tableItemList.append(floor0Table3)
        //        tableItemList.append(floor0Table4)
        //        tableItemList.append(floor0Table5)
        //        tableItemList.append(floor0Table6)
        //        tableItemList.append(floor0Table7)
        //        tableItemList.append(floor0Table8)
        //        tableItemList.append(floor0Table9)
        //        tableItemList.append(floor0Table10)
        //        tableItemList.append(floor0Table11)
        //        tableItemList.append(floor0Table12)
        //
        //
        //        let floor1Table1 = TableItem(floorCode: 1, tableCode: 13, tableName: "A1-001", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor1Table2 = TableItem(floorCode: 1, tableCode: 14, tableName: "A1-002", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor1Table3 = TableItem(floorCode: 1, tableCode: 15, tableName: "A1-003", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor1Table4 = TableItem(floorCode: 1, tableCode: 16, tableName: "A1-004", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor1Table5 = TableItem(floorCode: 1, tableCode: 17, tableName: "A1-005", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor1Table6 = TableItem(floorCode: 1, tableCode: 18, tableName: "A1-006", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor1Table7 = TableItem(floorCode: 1, tableCode: 19, tableName: "A1-007", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor1Table8 = TableItem(floorCode: 1, tableCode: 20, tableName: "A1-008", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor1Table9 = TableItem(floorCode: 1, tableCode: 21, tableName: "A1-009", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor1Table10 = TableItem(floorCode: 1, tableCode: 22, tableName: "A1-010", tableImage: "SixSeatsTable", statusOfTable: false, numberOfChair: 6)
        //        let floor1Table11 = TableItem(floorCode: 1, tableCode: 23, tableName: "A1-011", tableImage: "SixSeatsTable", statusOfTable: false, numberOfChair: 6)
        //        let floor1Table12 = TableItem(floorCode: 1, tableCode: 24, tableName: "A1-012", tableImage: "SixSeatsTable", statusOfTable: false, numberOfChair: 6)
        //        tableItemList.append(floor1Table1)
        //        tableItemList.append(floor1Table2)
        //        tableItemList.append(floor1Table3)
        //        tableItemList.append(floor1Table4)
        //        tableItemList.append(floor1Table5)
        //        tableItemList.append(floor1Table6)
        //        tableItemList.append(floor1Table7)
        //        tableItemList.append(floor1Table8)
        //        tableItemList.append(floor1Table9)
        //        tableItemList.append(floor1Table10)
        //        tableItemList.append(floor1Table11)
        //        tableItemList.append(floor1Table12)
        //
        //
        //        let floor2Table1 = TableItem(floorCode: 2, tableCode: 25, tableName: "A2-001", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor2Table2 = TableItem(floorCode: 2, tableCode: 26, tableName: "A2-002", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor2Table3 = TableItem(floorCode: 2, tableCode: 27, tableName: "A2-003", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor2Table4 = TableItem(floorCode: 2, tableCode: 28, tableName: "A2-004", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor2Table5 = TableItem(floorCode: 2, tableCode: 29, tableName: "A2-005", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor2Table6 = TableItem(floorCode: 2, tableCode: 30, tableName: "A2-006", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor2Table7 = TableItem(floorCode: 2, tableCode: 31, tableName: "A2-007", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor2Table8 = TableItem(floorCode: 2, tableCode: 32, tableName: "A2-008", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor2Table9 = TableItem(floorCode: 2, tableCode: 33, tableName: "A2-009", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor2Table10 = TableItem(floorCode: 2, tableCode: 34, tableName: "A2-010", tableImage: "SixSeatsTable", statusOfTable: false, numberOfChair: 6)
        //        let floor2Table11 = TableItem(floorCode: 2, tableCode: 35, tableName: "A2-011", tableImage: "SixSeatsTable", statusOfTable: false, numberOfChair: 6)
        //        let floor2Table12 = TableItem(floorCode: 2, tableCode: 36, tableName: "A2-012", tableImage: "SixSeatsTable", statusOfTable: false, numberOfChair: 6)
        //        tableItemList.append(floor2Table1)
        //        tableItemList.append(floor2Table2)
        //        tableItemList.append(floor2Table3)
        //        tableItemList.append(floor2Table4)
        //        tableItemList.append(floor2Table5)
        //        tableItemList.append(floor2Table6)
        //        tableItemList.append(floor2Table7)
        //        tableItemList.append(floor2Table8)
        //        tableItemList.append(floor2Table9)
        //        tableItemList.append(floor2Table10)
        //        tableItemList.append(floor2Table11)
        //        tableItemList.append(floor2Table12)
        //
        //        let floor3Table1 = TableItem(floorCode: 3, tableCode: 37, tableName: "A3-001", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor3Table2 = TableItem(floorCode: 3, tableCode: 38, tableName: "A3-002", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor3Table3 = TableItem(floorCode: 3, tableCode: 39, tableName: "A3-003", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor3Table4 = TableItem(floorCode: 3, tableCode: 40, tableName: "A3-004", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor3Table5 = TableItem(floorCode: 3, tableCode: 41, tableName: "A3-005", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor3Table6 = TableItem(floorCode: 3, tableCode: 42, tableName: "A3-006", tableImage: "FourSeatsTable",statusOfTable: false, numberOfChair: 4)
        //        let floor3Table7 = TableItem(floorCode: 3, tableCode: 43, tableName: "A3-007", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor3Table8 = TableItem(floorCode: 3, tableCode: 44, tableName: "A3-008", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor3Table9 = TableItem(floorCode: 3, tableCode: 45, tableName: "A3-009", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor3Table10 = TableItem(floorCode: 3, tableCode: 46, tableName: "A3-010", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor3Table11 = TableItem(floorCode: 3, tableCode: 47, tableName: "A3-011", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor3Table12 = TableItem(floorCode: 3, tableCode: 48, tableName: "A3-012", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        tableItemList.append(floor3Table1)
        //        tableItemList.append(floor3Table2)
        //        tableItemList.append(floor3Table3)
        //        tableItemList.append(floor3Table4)
        //        tableItemList.append(floor3Table5)
        //        tableItemList.append(floor3Table6)
        //        tableItemList.append(floor3Table7)
        //        tableItemList.append(floor3Table8)
        //        tableItemList.append(floor3Table9)
        //        tableItemList.append(floor3Table10)
        //        tableItemList.append(floor3Table11)
        //        tableItemList.append(floor3Table12)
        //
        //        let floor4Table1 = TableItem(floorCode: 4, tableCode: 49, tableName: "A4-001", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor4Table2 = TableItem(floorCode: 4, tableCode: 50, tableName: "A4-002", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor4Table3 = TableItem(floorCode: 4, tableCode: 51, tableName: "A4-003", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor4Table4 = TableItem(floorCode: 4, tableCode: 52, tableName: "A4-004", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor4Table5 = TableItem(floorCode: 4, tableCode: 53, tableName: "A4-005", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor4Table6 = TableItem(floorCode: 4, tableCode: 54, tableName: "A4-006", tableImage: "FourSeatsTable",statusOfTable: false, numberOfChair: 4)
        //        let floor4Table7 = TableItem(floorCode: 4, tableCode: 55, tableName: "A4-007", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor4Table8 = TableItem(floorCode: 4, tableCode: 56, tableName: "A4-008", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor4Table9 = TableItem(floorCode: 4, tableCode: 57, tableName: "A4-009", tableImage: "FourSeatsTable", statusOfTable: false, numberOfChair: 4)
        //        let floor4Table10 = TableItem(floorCode: 4, tableCode: 58, tableName: "A4-010", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor4Table11 = TableItem(floorCode: 4, tableCode: 59, tableName: "A4-011", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        let floor4Table12 = TableItem(floorCode: 4, tableCode: 60, tableName: "A4-012", tableImage: "TwoSeatsTable", statusOfTable: false, numberOfChair: 2)
        //        tableItemList.append(floor4Table1)
        //        tableItemList.append(floor4Table2)
        //        tableItemList.append(floor4Table3)
        //        tableItemList.append(floor4Table4)
        //        tableItemList.append(floor4Table5)
        //        tableItemList.append(floor4Table6)
        //        tableItemList.append(floor4Table7)
        //        tableItemList.append(floor4Table8)
        //        tableItemList.append(floor4Table9)
        //        tableItemList.append(floor4Table10)
        //        tableItemList.append(floor4Table11)
        //        tableItemList.append(floor4Table12)
    }
    
    func searchFloor(floorCodeInput: Int) -> [TableItem]{
        var tempTableList = [TableItem]()
        if(tableItemList.count > 0) {
            for index in 0...tableItemList.count - 1 {
                if tableItemList[index].floorCode == floorCodeInput {
                    tempTableList.append(tableItemList[index])
                }
            }
        }
        return tempTableList
    }
    
    func getSelectedTable(selectedTable: Int) -> TableItem? {
        for index in 0...tableItemList.count - 1 {
            if tableItemList[index].tableCode == selectedTable {
                return tableItemList[index]
            }
        }
        return nil
    }
    
}
