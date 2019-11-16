//
//  ListBooking.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 11/1/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import Foundation
import SnapKit

class ListBookingTableView: UIView, UITableViewDelegate, UITableViewDataSource, sentDataTo{
    
    func onDataUpdate() {
        bookBFCVC.removeSpinner()
        listBooking = listBook.listBooking
        tableView.reloadData()
    }
    
    var popupView = UIView()
    var blackVw = UIView()
    var bookBFCVC = ListBookBeforeComeViewController()
    var listBook = BookingBeforeUtils()
    var listBooking = [BookBefore]()
    
    // popup content
    var tenKH = UILabel()
    var tenLB = UILabel()
    var gmail = UILabel()
    var gmailLB = UILabel()
    var soNguoi = UILabel()
    var soNguoiLB = UILabel()
    var ngay = UILabel()
    var ngayLB = UILabel()
    var thoiGian = UILabel()
    var thoiGianLB = UILabel()
    var message = UILabel()
    var messageLB = UILabel()
    var cancelBt = UIButton()
    
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero)
        tb.delegate = self
        tb.dataSource = self
        tb.rowHeight = 50
        return tb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        listBook.getDataFromDataBase()
        listBook.delegate = self
        tableView.register(ListBookingTableViewCell.self, forCellReuseIdentifier: "cellid")
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        setupPopup()
    }
    
    func setupPopup(){
        blackVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancel)))
        cancelBt.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        
    }
    
    @objc func handleCancel(){
        UIView.animate(withDuration: 0.3, animations: {
            self.popupView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (Bool) in
            self.popupView.removeFromSuperview()
            self.blackVw.removeFromSuperview()
        }
        
    }
    
    func showPopup(data: BookBefore){
        
        addSubview(blackVw)
        blackVw.backgroundColor = UIColor.rgb(r: 53, g: 52, b: 52, a: 0.7)
        blackVw.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(bookBFCVC.view)
        }
        bookBFCVC.view.addSubview(popupView)
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 15.0
        popupView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.35)
            make.height.equalToSuperview().dividedBy(2)
        }
        
        popupView.addSubview(tenKH)
        tenKH.text = "Tên KH: "
        setupTitlePopup(target: tenKH)
        tenKH.snp.makeConstraints { (make) in
            make.leading.equalTo(popupView).inset(5)
            make.top.equalTo(popupView).inset(10)
            make.height.equalTo(popupView).dividedBy(12)
        }
        
        popupView.addSubview(tenLB)
        tenLB.text = data.tenKH
        tenLB.snp.makeConstraints { (make) in
            make.leading.equalTo(tenKH.snp.trailing)
            make.centerY.height.equalTo(tenKH)
            make.trailing.lessThanOrEqualTo(popupView).inset(5)
        }
        
        popupView.addSubview(gmail)
        gmail.text = "Gmail: "
        setupTitlePopup(target: gmail)
        gmail.snp.makeConstraints { (make) in
            make.leading.height.equalTo(tenKH)
            make.top.equalTo(tenKH.snp.bottom)
        }
        
        popupView.addSubview(gmailLB)
        gmailLB.text = data.gmail
        gmailLB.snp.makeConstraints { (make) in
            make.leading.equalTo(gmail.snp.trailing)
            make.centerY.height.equalTo(gmail)
            make.trailing.lessThanOrEqualTo(popupView).inset(5)
        }
        
        popupView.addSubview(soNguoi)
        soNguoi.text = "Số người: "
        setupTitlePopup(target: soNguoi)
        soNguoi.snp.makeConstraints { (make) in
            make.leading.height.equalTo(tenKH)
            make.top.equalTo(gmail.snp.bottom)
        }
        
        popupView.addSubview(soNguoiLB)
        soNguoiLB.text = String(data.soNguoi ?? 0)
        soNguoiLB.snp.makeConstraints { (make) in
            make.leading.equalTo(soNguoi.snp.trailing)
            make.centerY.height.equalTo(soNguoi)
        }
        
        popupView.addSubview(ngay)
        ngay.text = "Ngày: "
        setupTitlePopup(target: ngay)
        ngay.snp.makeConstraints { (make) in
            make.leading.height.equalTo(tenKH)
            make.top.equalTo(soNguoi.snp.bottom)
        }
        
        popupView.addSubview(ngayLB)
        ngayLB.text = data.ngay
        ngayLB.snp.makeConstraints { (make) in
            make.leading.equalTo(ngay.snp.trailing)
            make.centerY.height.equalTo(ngay)
        }
        
        popupView.addSubview(thoiGian)
        thoiGian.text = "Thời gian: "
        setupTitlePopup(target: thoiGian)
        thoiGian.snp.makeConstraints { (make) in
            make.leading.height.equalTo(tenKH)
            make.top.equalTo(ngay.snp.bottom)
        }
        
        popupView.addSubview(thoiGianLB)
        thoiGianLB.text = data.thoiGianDen
        thoiGianLB.snp.makeConstraints { (make) in
            make.leading.equalTo(thoiGian.snp.trailing)
            make.centerY.height.equalTo(thoiGian)
        }
        
        popupView.addSubview(message)
        message.text = "Lời nhắn:"
        setupTitlePopup(target: message)
        message.snp.makeConstraints { (make) in
            make.leading.height.equalTo(tenKH)
            make.top.equalTo(thoiGian.snp.bottom)
        }
        
        popupView.addSubview(messageLB)
        messageLB.text = data.message
        messageLB.numberOfLines = 0
        messageLB.sizeToFit()
        messageLB.snp.makeConstraints { (make) in
            make.leading.equalTo(tenKH)
            make.top.equalTo(message.snp.bottom)
            make.trailing.bottom.lessThanOrEqualTo(popupView).inset(5)
        }
        
        popupView.addSubview(cancelBt)
        cancelBt.setBackgroundImage(UIImage(named: "cancel"), for: .normal)
        cancelBt.layer.cornerRadius = 5.0
        cancelBt.snp.makeConstraints { (make) in
            make.height.width.equalTo(25)
            make.centerY.equalTo(popupView.snp.top).inset(5)
            make.centerX.equalTo(popupView.snp.trailing).inset(5)
        }
        cancelBt.layer.cornerRadius = 12
        cancelBt.clipsToBounds = true
        
    }
    
    func setupTitlePopup(target: UILabel){
        target.font = UIFont.systemFont(ofSize: 14)
        target.numberOfLines = 0
        target.sizeToFit()
//        target.layer.borderWidth = 1.0
        target.textColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBooking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as? ListBookingTableViewCell else { return UITableViewCell() }
        let data = listBooking[indexPath.row]
        cell.setContraint()
        cell.setDataInCell(ten: data.tenKH ?? "", tgden: data.thoiGianDen ?? "", songuoi: data.soNguoi ?? 0, gmail: data.gmail ?? "", message: data.message ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = listBooking[indexPath.row]
        UIView.animate(withDuration: 0.3, animations: {
            self.showPopup(data: data)
            self.popupView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (Bool) in
            
        }
    }
    
}

