//
//  ListOrderTableViewCell.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 9/17/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class ListOrderTableViewCell: UITableViewCell {

    var tenMon = UILabel()
    var them = UIButton()
    var bot = UIButton()
    var soluong = UILabel()
    var stackVw = UIStackView()
    var tongGiaMonAn = 0.0
    var giaMonAn = 0.0
    
    @objc func handleMoreBt(){
        if amount >= 0 && amount < 10{
            amount += 1
            soluong.text = "\(self.amount)"
            giaMonAn = Double(amount * gia1Mon)
        }
    }
    
    var gia1Mon = 0
    var amount = 1
    
    @objc func handleLessBt(){
        if amount > 0 && amount <= 10{
            amount -= 1
            soluong.text = "\(amount)"
            giaMonAn = Double(amount * gia1Mon)
        }
    }
    
    func setupContent(){
        addSubview(tenMon)
        tenMon.numberOfLines = 0
        tenMon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.width.equalTo(self.snp.width).dividedBy(1.8)
        }
        
        let coverVw = UIView()
        addSubview(coverVw)
        coverVw.snp.makeConstraints { (make) in
            make.centerY.equalTo(tenMon.snp.centerY)
            make.leading.equalTo(tenMon.snp.trailing).inset(-5)
            make.trailing.equalTo(self.snp.trailing).inset(10)
            make.height.equalTo(self.snp.height)
        }
        
        coverVw.addSubview(soluong)
        soluong.textAlignment = .center
        soluong.snp.makeConstraints { (make) in
            make.center.equalTo(coverVw.snp.center)
            make.height.width.equalTo(20)
        }
        
        coverVw.addSubview(them)
        them.setBackgroundImage(UIImage(named: "cong"), for: .normal)
        them.snp.makeConstraints { (make) in
            make.centerY.equalTo(soluong.snp.centerY)
            make.leading.equalTo(soluong.snp.trailing).offset(5)
            make.height.width.equalTo(30)
        }
        them.addTarget(self, action: #selector(handleMoreBt), for: .touchUpInside)
        
        coverVw.addSubview(bot)
        bot.setBackgroundImage(UIImage(named: "tru"), for: .normal)
        bot.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(soluong.snp.leading).inset(-5)
            make.height.width.equalTo(30)
        }
        bot.addTarget(self, action: #selector(handleLessBt), for: .touchUpInside)
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
