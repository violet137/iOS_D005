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

class CollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, sentData {
    func updataData() {
        DispatchQueue.global().async {
            self.monAnList = self.billUtil.list
        }
        DispatchQueue.main.async {
            self.collectionView!.reloadData()
        }
    }
    
    var ref: DatabaseReference!
    var billUtil = BillUtil()
    var monAnList = [MonAn]()
    var collectionView: UICollectionView?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layoutcv = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutcv)
        collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView!.delegate = self
        collectionView!.dataSource = self
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        layoutcv.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layoutcv.minimumInteritemSpacing = 0
        layoutcv.minimumLineSpacing = 0
        layoutcv.scrollDirection = .horizontal
        collectionView!.isPagingEnabled = true
        billUtil.dumpData()
        billUtil.delegate = self
        print("form CollectionView: \(monAnList.count)")
//        ref = Database.database().reference()
//        ref.child("MonAn").observeSingleEvent(of: .value) { (snapshot) in
//            self.monAnList.removeAll()
//            for item in snapshot.children {
//                let snap = item as! DataSnapshot
//                let dict = snap.value as! NSDictionary
//                let gia = dict["gia"] as? Int
//                let hinh = dict["hinh"] as? String
//                let loai = dict["loai"] as? Int
//                let ten = dict["ten"] as? String
//                let billitem = MonAn.init(monID: String(snap.key), gia: gia!, hinh: hinh!, loai: loai!, ten: ten!)
//                self.monAnList.append(billitem)
//                self.collectionView!.reloadData()
//            }
//            print("trong ref: \(self.monAnList)")
//        }
//        print("ngoai ref: \(self.monAnList)")
        
        view.addSubview(collectionView!)
        view.backgroundColor = .white
        collectionView!.layout.fill(view)
        collectionView!.backgroundColor = .white
    }
}
