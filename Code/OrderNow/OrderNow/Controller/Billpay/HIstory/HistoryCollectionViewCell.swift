//
//  HistoryCollectionViewCell.swift
//  OrderNow
//
//  Created by admin on 12/16/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell, delegateGetDataEarning {

    //****** Layout  ******//
    @IBOutlet weak var FooterView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var HisTableView: UITableView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var lbBillNum: UILabel!
    @IBOutlet weak var lbTableName: UILabel!
    @IBOutlet weak var lbTimePay: UILabel!
    @IBOutlet weak var lbStaffPay: UILabel!
    @IBOutlet weak var lbTongTien: UILabel!
    @IBOutlet weak var lbShowTongTien: UILabel!
    @IBOutlet weak var lineViewFooter: UIView!
    
    //******  Util variable.  ******//
    var earningUtil = EarningUtil()
    var earningList = [EarningsModel]()
    var historyViewController: HistoryViewController?
    var data = [BillPay]()
    
    static var identifier: String {
        return NSStringFromClass(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.earningUtil.getEarningData()
        self.earningUtil.delegateGetDataEarning = self
        HisTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
        HisTableView.delegate = self
        HisTableView.dataSource = self
    }
    
    func getTotal() -> Int {
        var total = 0
        for item in self.earningList {
            total += item.total!
        }
        return total
    }
    
    func getDataFromEarning() {
        DispatchQueue.global().async {
            self.earningList = self.earningUtil.earningTotalList
        }
        DispatchQueue.main.async {
            self.HisTableView.reloadData()
        }
    }
}

extension HistoryCollectionViewCell: UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.earningList.count
        self.HisTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        let data = self.earningList[indexPath.row]
        cell.lbBillName.text = "Bill_\(indexPath.row + 1)"
        cell.lbTableName.text = data.billPay![0].banName!
        cell.lbTimePay.text = data.time!
        cell.lbStaffPay.text = data.staff!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
        let VC = DetailHistoryTableViewController()
        VC.modalPresentationStyle = .fullScreen
        VC.modalTransitionStyle = .crossDissolve
        self.data = [self.earningList[indexPath.row].billPay![0]]
        VC.dataLoad = self.data
        HisTableView.reloadData()
        historyViewController!.present(VC, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
