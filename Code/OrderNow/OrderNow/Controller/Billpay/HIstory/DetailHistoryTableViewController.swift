//
//  DetailHistoryTableViewController.swift
//  OrderNow
//
//  Created by admin on 12/18/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import WWLayout

class DetailHistoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var detailTableView = UITableView()
    var dataLoad = [BillPay]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailTableView)
        detailTableView.register(UINib(nibName: "DetailHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailHistoryTableViewCell")
        detailTableView.register(UINib(nibName: "DetailHistoryFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailHistoryFooterView")
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.layout.fill(view)
    }

    // MARK: - Table view data source

//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataLoad[0].banID?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHistoryTableViewCell", for: indexPath) as! DetailHistoryTableViewCell
        let data = dataLoad[0].banID![indexPath.row]
        cell.imgView.image = UIImage(named: data.hinh!)
        cell.lbFoodName.text = data.monID!
        cell.lbQuatity.text = "\(data.soLuong!)"
        cell.lbTotalPrice.text = "\(data.soLuong! * data.gia!) đ"
        cell.detailView = self
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let VC = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailHistoryFooterView") as! DetailHistoryFooterView
        VC.detail = self
        
        return VC
    }
    
}
