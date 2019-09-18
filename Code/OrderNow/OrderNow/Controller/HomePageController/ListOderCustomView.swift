//
//  ListOderCustomView.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 9/17/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class ListOderTableView: UIView, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as? ListOrderTableViewCell else {
            return UITableViewCell()
        }
        cell.setupContent()
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
