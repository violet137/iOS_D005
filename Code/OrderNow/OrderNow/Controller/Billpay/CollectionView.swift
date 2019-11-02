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
    func sentSearchDataBack(with data: [MonAnBill])
}

class BillPayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, sentData, dataPassBillDelele {
    func getTable(with data: [TableItem]) {
        self.table = data
    }
    
    func updataData() {
        DispatchQueue.global().async {
            self.billListCV = self.billUtil.billList
//            self.searchBill = self.billUtil.filterBill(ban: "2")
        }
        DispatchQueue.main.async {
            self.collectionView!.reloadData()
        }
    }
    
    var dataDelegate: dataBackDelegate?
    var billUtil = BillUtil()
    var billListCV = [BillPay]()
    var searchBill = [MonAnBill]()
    var collectionView: UICollectionView?
    var table = [TableItem]()
    var tableVC = TableViewController()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.billListCV.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillViewCell.identifier, for: indexPath) as! BillViewCell
        let data = self.billListCV[indexPath.row]
        cell.leftHeaderPeople.text = "2"
        cell.rightHeaderLabel.text = "Bàn \(data.banName!)"
        var totalPrice = 0
        for item in data.banID! {
            totalPrice = totalPrice + (item.gia! * item.soLuong!)
        }
        cell.labelFooterTotalPrice.text = "\(totalPrice)"
        cell.billDelegate.dataDelegate?.sentDataBack(with: data.banID!)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Get data from firebase
        billUtil.getOrderList()
        billUtil.delegate = self
        self.dataDelegate?.sentSearchDataBack(with: self.searchBill)
        self.tableVC.dataPassBillDelele = self
        
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
