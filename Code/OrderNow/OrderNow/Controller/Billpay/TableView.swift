//
//  TableViewViewController.swift
//  OrderNow
//
//  Created by admin on 9/5/19.
//  Copyright © 2019 ForLearn. All rights reserved.
//

import UIKit
import WWLayout
import Firebase

protocol _NumberDelegate {
    func increassNumber(View: BillpayController, number: Int)
    func decreassNumber(View: BillpayController, number: Int)
}

class BillpayController: UIViewController, UITableViewDelegate, UITableViewDataSource,sentData {
    func updataData() {
        DispatchQueue.global().async {
            self.listMon = self.billUtil.list
            self.billList = self.billUtil.billList
        }
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    var numberDelegate: _NumberDelegate?
    var minValue = 0
    var billUtil = BillUtil()
    var listMon = [MonAnBill]()
    var billList = [BillPay]()
    //*****headerview
    var headerView = UIView()
    var leftHeaderStackView = UIStackView()
    var leftHeaderImage = UIImageView()
    var btnHeaderMinus = UIButton()
    var leftHeaderPeople = UILabel()
    var btnHeaderAdd = UIButton()
    var rightHeaderStackView = UIStackView()
    var rightHeaderLabel = UILabel()
    var rightHeaderImage = UIImageView()

    //******bodyView
    var bodyView = UIView()

    //******footerView
    var footerView = UIView()
    var lineFooterView = UIView()
    var labelFooterTotal = UILabel()
    var labelFooterTotalPrice = UILabel()
    var btnFooterPay = UIButton()
    var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        billUtil.delegate = self
        billUtil.getOrderList()
        print(listMon.count)

        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(bodyView)
        view.addSubview(footerView)

        //*******headerView autolayout
        //headerView.backgroundColor = .blue
        headerView.layout
            .leading(to: view)
            .top(to: view.safeAreaLayoutGuide)
            .trailing(to: view)
            .height(to: 0.1 * view.frame.height)
        headerView.addSubview(leftHeaderImage)
        leftHeaderImage.image = UIImage(named: "iconNoOfPeple")
        leftHeaderImage.layout
            .width(30).height(30)
            .leading(to: headerView, edge: .leading, offset: 10)
            .centerY(to: headerView)
        headerView.addSubview(leftHeaderStackView)
        leftHeaderStackView.layer.borderWidth = 1
        leftHeaderStackView.layer.borderColor = UIColor.black.cgColor
        leftHeaderStackView.layout
            .leading(to: leftHeaderImage, edge: .trailing, offset: 15)
            .centerY(to: headerView)
        leftHeaderStackView.axis = .horizontal
        leftHeaderStackView.distribution = .equalSpacing
        leftHeaderStackView.alignment = .center
        leftHeaderStackView.spacing = 20
        btnHeaderMinus.setTitle("-", for: .normal)
        btnHeaderMinus.addTarget(self, action: #selector(decreaseFunc), for: .touchUpInside)
        btnHeaderMinus.setBorder(width: 1.0, color: .lightGray)
        btnHeaderMinus.layout.width(20).height(20)
        btnHeaderMinus.setRadius(radius: 10)
        btnHeaderMinus.setTitleColor(.orange, for: .normal)
        btnHeaderMinus.setFont(size: 18, weight: .light)
        btnHeaderMinus.setShawdow(color: .black, width: 0.0, height: 1.0, radius: 1, opacity: 0.4)
        leftHeaderStackView.addArrangedSubview(btnHeaderMinus)
        leftHeaderPeople.text = "1"
        leftHeaderPeople.setFont(size: 20, weight: .bold)
        leftHeaderPeople.textColor = .orange
        leftHeaderStackView.addArrangedSubview(leftHeaderPeople)
        btnHeaderAdd.setTitle("+", for: .normal)
        btnHeaderAdd.addTarget(self, action: #selector(increaseFunc), for: .touchUpInside)
        btnHeaderAdd.setBorder(width: 1.0, color: .lightGray)
        btnHeaderAdd.layout.width(20).height(20)
        btnHeaderAdd.setRadius(radius: 10)
        btnHeaderAdd.setTitleColor(.orange, for: .normal)
        btnHeaderAdd.setFont(size: 18, weight: .light)
        btnHeaderAdd.setShawdow(color: .black, width: 0.0, height: 1.0, radius: 1, opacity: 0.4)
        leftHeaderStackView.addArrangedSubview(btnHeaderAdd)
        headerView.addSubview(rightHeaderStackView)
        rightHeaderStackView.layout
            .trailing(to: headerView, edge: .trailing, offset: -10)
            .centerY(to: headerView)
        rightHeaderStackView.axis = .horizontal
        rightHeaderStackView.distribution = .equalSpacing
        rightHeaderStackView.spacing = 10
        rightHeaderStackView.alignment = .center
        rightHeaderLabel.text = " Ban 2, Ban 3"
        rightHeaderLabel.textColor = .gray
        rightHeaderLabel.setFont(size: 18, weight: .bold)
        rightHeaderStackView.addArrangedSubview(rightHeaderLabel)
        rightHeaderImage.image = UIImage(named: "iconTable")
        rightHeaderImage.layout.width(30).height(30)
        rightHeaderStackView.addArrangedSubview(rightHeaderImage)

        //******footerView autoLayout
        footerView.layout
            .leading(to: view)
            .trailing(to: view)
            .bottom(to: view.safeAreaLayoutGuide)
            .height(to: 0.1 * view.frame.height)
        footerView.addSubview(lineFooterView)
        lineFooterView.backgroundColor = .orange
        lineFooterView.layout
            .width(to: footerView.layout.width * 0.8)
            .height(2)
            .trailing(to: footerView, edge: .trailing)
            .top(to: footerView, edge: .top)
        lineFooterView.addSubview(labelFooterTotal)
        labelFooterTotal.text = "TONG CONG"
        labelFooterTotal.setFont(size: 17, weight: .medium)
        footerView.addSubview(labelFooterTotal)
        labelFooterTotal.layout
            .centerY(to: footerView)
            .leading(to: lineFooterView, edge: .leading)
        footerView.addSubview(btnFooterPay)
        btnFooterPay.setTitle(">", for: .normal)
        btnFooterPay.setTitleColor(.orange, for: .normal)
        btnFooterPay.setFont(size: 20, weight: .semibold)
        btnFooterPay.setBorder(width: 1, color: .lightGray)
        btnFooterPay.layout.width(40).height(40)
        btnFooterPay.setRadius(radius: 20)
        btnFooterPay.setShawdow(color: .black, width: 0, height: 2, radius: 2, opacity: 0.5)
        btnFooterPay.layout
            .centerY(to: footerView)
            .trailing(to: footerView, edge: .trailing, offset: -10)
        labelFooterTotalPrice.text = "765,000"
        labelFooterTotalPrice.textColor = .orange
        labelFooterTotalPrice.setFont(size: 25, weight: .semibold)
        footerView.addSubview(labelFooterTotalPrice)
        labelFooterTotalPrice.layout
            .centerY(to: footerView)
            .trailing(to: btnFooterPay, edge: .leading, offset: -20)

        //******bodyView
        view.addSubview(bodyView)
        bodyView.backgroundColor = .yellow
        bodyView.layout
            .top(to: headerView, edge: .bottom)
            .leading(to: view).trailing(to: view)
            .bottom(to: footerView, edge: .top)
        tableView = UITableView(frame: bodyView.bounds, style: UITableView.Style.grouped)
        tableView!.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView!.translatesAutoresizingMaskIntoConstraints = false
        tableView!.delegate = self
        tableView!.dataSource = self
        tableView!.rowHeight = 150
        tableView!.estimatedRowHeight = UITableView.automaticDimension
        bodyView.addSubview(tableView!)
            tableView!.layout.fill(bodyView)
        print(billUtil.list.count)
    }
    
    //******DataSource****
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        count = self.billList[section].banID!.count
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
        let data = self.billList[indexPath.section].banID![indexPath.row]
//        cell?.billUtil = data
        cell?.foodImage.image = UIImage(named: data.hinh!)
        cell?.foodName.text = data.ten
        cell?.foodNote.text = "Test choi thoi"
        cell?.foodPrice.text = "\(data.gia!)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    @objc func increaseFunc() {
        changeQuantity(by: 1)
    }
    
    @objc func decreaseFunc() {
        changeQuantity(by: -1)
    }
    
    func changeQuantity(by amount: Int) {
        var noPeople = Int(leftHeaderPeople.text!)!
        noPeople += amount
        if noPeople < minValue {
            noPeople = 0
            leftHeaderPeople.text = "0"
        } else {
            leftHeaderPeople.text = "\(noPeople)"
        }
        numberDelegate?.decreassNumber(View: self, number: noPeople)
    }
    
}

