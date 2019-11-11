//
//  BookingListTableViewCell.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 11/1/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class ListBookingTableViewCell: UITableViewCell {

    var tenKH = UILabel()
    var tgDen = UILabel()
    var soNguoi = UILabel()
    var gmail = UILabel()
    var message = UILabel()
    
    
    func setDataInCell(ten: String, tgden: String, songuoi: Int, gmail: String, message: String){
        self.tenKH.text = ten
        self.tgDen.text = tgden
        self.soNguoi.text = String(songuoi)
        self.gmail.text = gmail
        self.message.text = message
    }
    
    func setContraint(){
        
        addSubview(tenKH)
        tenKH.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(15)
            make.bottom.equalTo(self.snp.centerY)
        }
        addSubview(gmail)
        gmail.textColor = .lightGray
        gmail.font = UIFont.systemFont(ofSize: 13)
        gmail.snp.makeConstraints { (make) in
            make.leading.equalTo(tenKH.snp.leading)
            make.top.equalTo(tenKH.snp.bottom)
            
        }
        
        addSubview(tgDen)
        tgDen.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
