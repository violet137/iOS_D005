//
//  ListOderCustomView.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 9/17/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit


class ListOderTableView: UIView, UITableViewDelegate, UITableViewDataSource{
    
    var ListOrder = [OrderModal]()
    var homePage = HomePageController()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = ListOrder[indexPath.item]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as? ListOrderTableViewCell else {
            return UITableViewCell()
        }
        cell.setupContent()
        cell.amount = Int(data.soLuongDat!)
        cell.tenMon.text = data.tenMon
        cell.soluong.text = String(data.soLuongDat!)
        return cell
    }
    
    lazy var tableView : UITableView = {
        let tbv = UITableView(frame: .zero)
        tbv.delegate = self
        tbv.dataSource = self
        return tbv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        tableView.register(ListOrderTableViewCell.self, forCellReuseIdentifier: "cellid")
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
