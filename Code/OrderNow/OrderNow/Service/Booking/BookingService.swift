//
//  BookingService.swift
//  OrderNow
//
//  Created by ADMIN on 9/18/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import Firebase

class BookingService {
    var refDataFirebase : DatabaseReference!
    
    init() {
        refDataFirebase = Database.database().reference()
    }
    
    func BookingTable(id:String, completion:  @escaping (_ status: Bool,_ data: BookingTableOutput?,  _ error: Error?) -> Void ) -> Void {
    
        GetDetailTable(id: id ){ (status, data, error) in
            if status && data != nil{
                guard let data = data else {
                    return
                }
                
                switch data.Status {
                case 0 : // bàn trống
                    self.SetStatusTable(id: id)
                    completion(true,BookingTableOutput(message: "Chờ xác nhận",status: 0),nil)
                    self.ListenerBookingStatus(id: id){ (status, error) in
                        if status {
                            completion(true,BookingTableOutput(message: "Đặt bàn thành công",status: 1),nil)
                        }else{
                            var mes = "Đặt bàn không thành công"
                            if error != nil {
                                mes = error!.localizedDescription
                            }
                            
                            completion(true,BookingTableOutput(message: mes,status: -1), nil)
                        }
                    }
                    break
                case 1,2,3 : // chờ xác nhận, khách hàng đang order, nhân viên đang order
                    completion(true,BookingTableOutput(message: "Bàn đã có người đặt",status: -1),error)
                    break
                default : // lỗi
                    completion(true,BookingTableOutput(message: "lỗi: Vui lòng chọn lại",status: -1),error)
                    break
                }
            }else{
                completion(false,nil,error)
            }
        }
    }
    
    func ListenerBookingStatus(id:String, completion:  @escaping (_ status: Bool, _ error: Error?) -> Void) -> Void {
        refDataFirebase.child("table-items").child(id).observeSingleEvent(of: .childChanged, with: { (snapshot) in
            self.GetDetailTable(id: id ){ (status, data, error) in
                // Get value
                if data != nil &&  data!.Status == 2 {
                    completion(true,nil)
                }else{
                    let domain = ""
                    let code = -1
                    let info = [NSLocalizedDescriptionKey: """
                        Yêu cầu không thành công
                        Vui lòng chọn lại.
                        """]
                    let error = NSError(domain: domain, code: code, userInfo: info)
                    completion(false,error)
                }
            }
        }) { (error) in
            completion(false,error)
        }
    }
    
    func SetStatusTable(id:String) -> Void {
        refDataFirebase.child("table-items").child(id).updateChildValues(["status" : 1])
    }
    
    func GetDetailTable(id:String, completion:  @escaping (_ status: Bool,_ data: DetailTableOutput? , _ error: Error?) -> Void ) -> Void {
        refDataFirebase.child("table-items").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get value
            let value = snapshot.value as? NSDictionary
            
            let chairs = value?["chairs"] as? Int ?? -1
            let floor = value?["floor"] as? Int ?? -1
            let image = value?["image"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            let status = value?["status"] as? Int ?? -1
            
            completion(true,DetailTableOutput(chairs,floor,image,name,status),nil)
            
        }) { (error) in
            completion(false,nil,error)
        }
    }
}
