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
    func choXacNhan(ban:TableItem)
    func changeStatus(ban: String)
}


class TableUtils {
    var tableItemList = [TableItem]()
    var ref: DatabaseReference!
    var callback:TableCallback?
    
    func tableListening(callback:TableCallback)  {
        self.callback = callback
        ref.child("table-items").observe(.childChanged) { (snapshot) in
            self.dumpData()
            
            let dict = snapshot.value as! NSDictionary
            let status =  dict["status"] as? Int
            if(status == 1){
                let floor = dict["floor"] as? Int
                let image =  dict["image"] as? String
                let name =  dict["name"] as? String
                let status =  dict["status"] as? Int
                let people = dict["people"] as? Int
                let chairs =  dict["chairs"] as? Int
                let table = TableItem(floorCode: floor!, tableCode: Int(snapshot.key)!, tableName:name!, tableImage: image!, statusOfTable: status!, numberOfPeople: people!, numberOfChair: chairs!)
                self.callback?.choXacNhan(ban: table)
            }
        }
    }
    
    func changeStatus(ban: String){
        self.ref = Database.database().reference()
        self.ref.child("table-items").observe(.value) { (snapshot) in
            for child in snapshot.children.allObjects {
                let snap = child as! DataSnapshot
                let childRef = snapshot.childSnapshot(forPath: snap.key)
                for grandchild in childRef.children{
                    let childsnap = grandchild as! DataSnapshot
                    let dict = snap.value as! NSDictionary
                    let tenban = dict["name"] as! String
                    if(tenban == ban){
                        self.ref.child("table-items").child(snap.key).updateChildValues(["status" : 0])
                        self.ref.child("table-items").child(snap.key).updateChildValues(["people" : 0])
                    }
                }
            }
            self.callback?.changeStatus(ban: ban)
        }
    }
    
    func dumpData() {
        self.ref = Database.database().reference()
        self.ref.child("table-items").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get table value
            self.tableItemList.removeAll()
            for item in snapshot.children {
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let floor = dict["floor"] as? Int
                let image =  dict["image"] as? String
                let name =  dict["name"] as? String
                let status =  dict["status"] as? Int
                let people = dict["people"] as? Int
                let chairs =  dict["chairs"] as? Int
                let table = TableItem(floorCode: floor!, tableCode: Int(snap.key)!, tableName:name!, tableImage: image!, statusOfTable: status!, numberOfPeople: people!, numberOfChair: chairs!)
                self.tableItemList.append(table)
                //print("ban: \(item)")
            }
            self.callback?.onDataUpdate()
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func searchFloor(floorCodeInput: Int) -> [TableItem]{
        var tempTableList = [TableItem]()
        if(self.tableItemList.count > 0) {
            for index in 0...self.tableItemList.count - 1 {
                if self.tableItemList[index].floorCode == floorCodeInput {
                    tempTableList.append(self.tableItemList[index])
                }
            }
        }
        return tempTableList
    }
    
    func getSelectedTable(selectedTable: Int) -> TableItem? {
        for index in 0...self.tableItemList.count - 1 {
            if self.tableItemList[index].tableCode == selectedTable {
                return self.tableItemList[index]
            }
        }
        return nil
    }
    
}
