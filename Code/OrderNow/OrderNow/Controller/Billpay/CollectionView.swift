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

class BillPayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, sentData {
    func updataData() {
        DispatchQueue.global().async {
            self.monAnList = self.billUtil.list
            self.billListCV = self.billUtil.billList
        }
        DispatchQueue.main.async {
            self.collectionView!.reloadData()
        }
    }
    
//    var ref: DatabaseReference!
    var billUtil = BillUtil()
    var monAnList = [MonAnBill]()
    var billListCV = [BillPay]()
    var collectionView: UICollectionView?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return billListCV.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillViewCell.identifier, for: indexPath) as! BillViewCell
        let data = billListCV[indexPath.row]
        cell.leftHeaderPeople.text = "2"
        cell.rightHeaderLabel.text = "Bàn \(data.banName)"
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layoutcv = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutcv)
        
       
        layoutcv.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layoutcv.minimumInteritemSpacing = 0
        layoutcv.minimumLineSpacing = 0
        layoutcv.scrollDirection = .horizontal
        collectionView!.isPagingEnabled = true
        billUtil.getOrderList()
        billUtil.delegate = self
        collectionView!.register(BillViewCell.self, forCellWithReuseIdentifier: BillViewCell.identifier)
        collectionView!.delegate = self
        collectionView!.dataSource = self
        print("form CollectionView: \(billListCV.count)")
        view.addSubview(collectionView!)
        view.backgroundColor = .white
        collectionView!.layout.fill(view)
        collectionView!.backgroundColor = .white
    }
}
