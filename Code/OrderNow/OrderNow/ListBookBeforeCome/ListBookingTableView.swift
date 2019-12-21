//
//  ListBooking.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 11/1/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import Foundation
import SnapKit
import Firebase
import FirebaseDatabase

class ListBookingTableView: UIView, UITableViewDelegate, UITableViewDataSource, sentDataTo{
    
    func onDataUpdate() {
        listBookBFCVC.removeSpinner()
        listBooking = listBookBFUtils.listBooking
        tableView.reloadData()
    }
    
    var popupView = UIView()
    var blackVw = UIView()
    var listBookBFCVC = ListBookBeforeComeViewController()
    var listBookBFUtils = BookingBeforeUtils()
    var listBooking = [BookBefore]()
    var ref: DatabaseReference!

    
    
    // popup content
    var tenLB = UILabel()
    var soNguoiLB = UILabel()
    var thoiGianLB = UILabel()
    var messageLB = UILabel()
    var dismissBt = UIButton()
    var doneBt = UIButton()
    
    var idHd: String?
    
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero)
        tb.delegate = self
        tb.dataSource = self
        tb.rowHeight = 50
        return tb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ref = Database.database().reference()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkData), userInfo: nil, repeats: true)
        listBookBFUtils.delegate = self
        tableView.register(ListBookingTableViewCell.self, forCellReuseIdentifier: "cellid")
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        
    }
    
    @objc func checkData(){
        
        listBookBFUtils.getDataFromDataBase()
        let formatter = DateFormatter()
        let date = Date()
        formatter.dateFormat = "yyyy/MM/dd-HH:mm"
        let currentDate = formatter.string(from: date)
        for item in listBooking{
            if item.thoiGianDen! < currentDate{
                ref.child("DatTruoc").child(item.idDonHang!).updateChildValues(["status" : 0])
            }
        }
    }
    
    
    
    func setupPopup(){
        blackVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancel)))
        dismissBt.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        doneBt.addTarget(self, action: #selector(doneAct), for: .touchUpInside)
    }
    
    @objc func doneAct(){
        
        let alert = UIAlertController(title: "WARNING!", message: "Are you sure you want to cancel it?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
            self.ref.child("DatTruoc").child(self.idHd!).updateChildValues(["status" : 0])
            UIView.animate(withDuration: 0.3, animations: {
                self.popupView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }) { (Bool) in
                self.popupView.removeFromSuperview()
                self.blackVw.removeFromSuperview()
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }))
        DispatchQueue.main.async {
            self.listBookBFCVC.present(alert, animated: true, completion: nil)
        }
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
            make.leading.trailing.top.bottom.equalTo(listBookBFCVC.view)
        }
        listBookBFCVC.view.addSubview(popupView)
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 15.0
        popupView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.35)
            make.height.equalToSuperview().dividedBy(2)
            
        }
        
        popupView.addSubview(dismissBt)
        dismissBt.setBackgroundImage(UIImage(named: "cancel"), for: .normal)
        dismissBt.layer.cornerRadius = 5.0
        dismissBt.snp.makeConstraints { (make) in
            make.height.width.equalTo(25)
            make.centerY.equalTo(popupView.snp.top).inset(5)
            make.centerX.equalTo(popupView.snp.trailing).inset(5)
        }
        dismissBt.layer.cornerRadius = 12
        dismissBt.clipsToBounds = true
        
        if data.status == 0{
            doneBt.isHidden = true
        }else{
            doneBt.isHidden = false
        }
        
        popupView.addSubview(doneBt)
        doneBt.backgroundColor = .systemGreen
        doneBt.setAttributedTitle(NSAttributedString(string: "Cancel Bill", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]), for: .normal)
        doneBt.layer.cornerRadius = 8.0
        doneBt.snp.makeConstraints { (make) in
            make.centerX.equalTo(popupView)
            make.width.equalTo(popupView).dividedBy(2)
            make.height.equalTo(popupView).dividedBy(8)
            make.bottom.equalTo(popupView).offset(-15)
        }
        setupPopup()
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
        cell.setDataInCell(ten: data.soDT ?? "", tgden: data.thoiGianDen ?? "", songuoi: data.soNguoi ?? 0, message: data.message ?? "", user: "", status: data.status ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = listBooking[indexPath.row]
        idHd = data.idDonHang
        UIView.animate(withDuration: 0.3, animations: {
            self.showPopup(data: data)
            self.popupView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (Bool) in
            
        }
    }
    
}

extension UIButton{
    func animated(){
        UIButton.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            if finished{
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
