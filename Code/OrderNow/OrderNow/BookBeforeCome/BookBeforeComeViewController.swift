//
//  BookBeforeComeViewController.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 11/11/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import SnapKit

class BookBeforeComeViewController: UIViewController {
    
    var navBarTitle = UILabel()
    var tenKHLb = UILabel()
    var messageLb = UILabel()
    var messageTF = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rgb(r: 245, g: 245, b: 245, a: 1)
        setupNavBar()
        setupContent()
    }
    
    func setupContent(){
        
        view.addSubview(messageLb)
        messageLb.text = "Lời nhắn"
        messageLb.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.centerY)
            make.leading.equalToSuperview().inset(15)
        }
        
        view.addSubview(messageTF)
        messageTF.backgroundColor = .white
        messageTF.layer.borderWidth = 0.5
        messageTF.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(messageLb.snp.bottom)
            make.height.equalToSuperview().dividedBy(4)
        }
    }
    
    func setupNavBar(){
        navBarTitle.text = "Đặt Trước"
        navBarTitle.textColor = .systemPink
        navigationController?.navigationBar.addSubview(navBarTitle)
        navBarTitle.snp.makeConstraints { (make) in
            make.center.equalTo((navigationController?.navigationBar.snp.center)!)
        }
        
    }
    
    
}


