//
//  CollectionView.swift
//  OrderNow
//
//  Created by admin on 9/17/19.
//  Copyright © 2019 ForLearn. All rights reserved.
//

import UIKit
import WWLayout
import Firebase

protocol dataBackDelegate {
    func sentDataBack(with data: [MonAnBill])
    func sentBillDataBack(with data: [BillPay])
    func sentTableCode(tableName: String)
}

protocol ThanhToanBanDelegate {
    func thanhToan()
    func dong()
}

class BillPayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, sentData, ThanhToanBanDelegate/*, dataPassBillDelegate */{
    
    func thanhToan() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func dong() {
        // thong báo
    }
    
    func getTable(statusCode: Int, ID: Int) {
        self.statusCode = statusCode
        self.tableID = ID
    }
    
    func getTable(with data: [TableItem]) {
        self.table = data
    }
    
    func updataData() {
        DispatchQueue.global().async {
            self.billListCV = self.billUtil.billList
        }
        DispatchQueue.main.async {
            self.collectionView!.reloadData()
            // duyet vao ban dang nhan
            var viTri = 0
            for item in self.billUtil.billList {
                viTri = viTri + 1
                if(item.banName! == self.tenBan!){
                    break
                }
            }
            self.collectionView!.scrollToItem(at: IndexPath(row: viTri - 1, section: 0), at: .right, animated: true)
        }
    }
    
    var dataDelegate: dataBackDelegate?
    var billUtil = BillUtil()
    var billListCV = [BillPay]()
    var collectionView: UICollectionView?
    var table = [TableItem]()
    let tableVC = TableViewController()
    var tableID: Int?
    var tenBan: String?
    var statusCode: Int?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.billListCV.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillViewCell.identifier, for: indexPath) as! BillViewCell
        let data = self.billListCV[indexPath.row]
        cell.billVC.dataDelegate?.sentBillDataBack(with: [data])
        cell.thanhToanDelegate = self
        cell.leftHeaderPeople.text = "2"
        cell.rightHeaderLabel.text = "Bàn \(data.banName!)"
        var totalPrice = 0
        for item in data.banID! {
            totalPrice = totalPrice + (item.gia! * item.soLuong!)
        }
        cell.labelFooterTotalPrice.text = "\(totalPrice)"
        // loc data theo ban
        cell.billVC.dataDelegate?.sentDataBack(with: data.banID!)
        cell.billVC.dataDelegate?.sentTableCode(tableName: data.banName!)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get data from firebase
        billUtil.getOrderList()
        billUtil.delegate = self
        let layoutcv = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutcv)
        
       
        layoutcv.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layoutcv.minimumInteritemSpacing = 0
        layoutcv.minimumLineSpacing = 0
        layoutcv.scrollDirection = .horizontal
        collectionView!.isPagingEnabled = true
        collectionView!.register(BillViewCell.self, forCellWithReuseIdentifier: BillViewCell.identifier)
        collectionView!.delegate = self
        collectionView!.dataSource = self
        view.addSubview(collectionView!)
        view.backgroundColor = .white
        collectionView!.layout.fill(view)
        collectionView!.backgroundColor = .white
    }
    
}
