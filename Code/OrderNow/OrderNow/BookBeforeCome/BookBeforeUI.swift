//
//  BookBeforeUI.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 12/4/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

extension BookBeforeComeViewController{
    
    func setupContent(){
        
        
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        scrollView.addSubview(bookingImg)
        bookingImg.image = UIImage(named: "booking")
        bookingImg.contentMode = .scaleAspectFit
        bookingImg.snp.makeConstraints { (make) in
            
            make.top.equalTo(scrollView).offset(self.view.frame.height / 10)
            make.left.right.equalTo(view)
        }
        
        
        scrollView.addSubview(tenLb)
        tenLb.text = "Tên người đặt"
        tenLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view).inset(20)
            make.top.equalTo(bookingImg.snp.bottom).offset(20)
        }
        
        scrollView.addSubview(tenTF)
        paddingTf(tf: tenTF)
        tenTF.setUpFirst()
        tenTF.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(view).inset(20)
            make.top.equalTo(tenLb.snp.bottom).offset(5)
            make.height.equalTo(35)
        }
        
        scrollView.addSubview(tgdenLb)
        tgdenLb.text = "Thời gian hẹn"
        tgdenLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(tenLb)
            make.top.equalTo(tenTF.snp.bottom).offset(5)
        }
        
        scrollView.addSubview(tgDenTF)
        tgDenTF.setUpFirst()
        paddingTf(tf: tgDenTF)
        tgDenTF.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(tenTF)
            make.top.equalTo(tgdenLb.snp.bottom).offset(5)
            make.height.equalTo(35)
        }
        
        scrollView.addSubview(soluongLb)
        soluongLb.text = "Số người"
        soluongLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(tenLb)
            make.top.equalTo(tgDenTF.snp.bottom).offset(5)
        }
        
        scrollView.addSubview(soluongTF)
        soluongTF.setUpFirst()
        paddingTf(tf: soluongTF)
        soluongTF.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(tenTF)
            make.top.equalTo(soluongLb.snp.bottom).offset(5)
            make.height.equalTo(35)
        }
        
        scrollView.addSubview(messageLb)
        messageLb.text = "Message"
        messageLb.snp.makeConstraints { (make) in
            make.top.equalTo(soluongTF.snp.bottom).offset(5)
            make.leading.trailing.equalTo(tenLb)
        }
        
        scrollView.addSubview(messageTF)
        messageTF.setUpFirst()
        paddingTf(tf: messageTF)
        messageTF.contentVerticalAlignment = .top
       
        messageTF.textAlignment = .justified
        messageTF.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(tenLb)
            make.top.equalTo(messageLb.snp.bottom).offset(5)
            make.height.equalTo(200)
            
        }
        
        scrollView.addSubview(acceptBt)
        acceptBt.setAttributedTitle(NSAttributedString.init(string: "Accept", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]), for: .normal)
        acceptBt.backgroundColor = .green
        acceptBt.layer.cornerRadius = 10
        acceptBt.addTarget(self, action: #selector(acceptAct), for: .touchUpInside)
        acceptBt.snp.makeConstraints { (make) in
            make.centerX.equalTo(scrollView)
            make.width.equalTo(view).dividedBy(2)
            make.height.equalTo(50)
            make.top.equalTo(messageTF.snp.bottom).offset(20)
            make.bottom.equalTo(scrollView).offset(-150)
        }
    }
         
    
}
