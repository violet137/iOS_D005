//
//  HistoryViewController.swift
//  OrderNow
//
//  Created by admin on 12/15/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import Firebase
import SnapKit
import WWLayout

class HistoryViewController: UIViewController, delegateGetDataEarning {
    func getDataFromEarning() {
        DispatchQueue.global().async {
            self.earningList = self.earningUtil.earningTotalList
        }
        DispatchQueue.main.async {
            self.historyCollectionView!.reloadData()
        }
    }
    
    var historyCollectionView: UICollectionView?
    var earningUtil = EarningUtil()
    var earningList = [EarningsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectioView()
        print(self.earningList)
        earningUtil.getEarningData()
        earningUtil.delegateGetDataEarning = self
        
    }
}

extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCollectionViewCell", for: indexPath) as! HistoryCollectionViewCell
        collectionCell.historyViewController = self
        let total = collectionCell.getTotal() as NSNumber
        let numberformat = NumberFormatter()
        numberformat.numberStyle = .currency
        numberformat.positiveFormat = "#,##0 Đ"
        let totalString = numberformat.string(from: total)
        
        collectionCell.lbShowTongTien.text = totalString
        return collectionCell
    }
    
    func setupCollectioView(){
        let layoutcv = UICollectionViewFlowLayout()
        historyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutcv)
         layoutcv.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
         layoutcv.minimumInteritemSpacing = 0
         layoutcv.minimumLineSpacing = 0
         layoutcv.scrollDirection = .horizontal
         historyCollectionView!.isPagingEnabled = true
        let nibName = UINib(nibName: "HistoryCollectionViewCell", bundle: nil)
        historyCollectionView!.register(nibName, forCellWithReuseIdentifier: "HistoryCollectionViewCell")
         self.historyCollectionView!.delegate = self
         self.historyCollectionView!.dataSource = self
         view.addSubview(historyCollectionView!)
         view.backgroundColor = .white
         historyCollectionView!.layout.fill(view)
         historyCollectionView!.backgroundColor = .white
    }
    
//    static func formatCurrency(_ inputNumber: NSNumber, symbol: String = "VND") -> String {
//      let formatter = NumberFormatter()
//      formatter.currencySymbol = symbol
//      formatter.currencyGroupingSeparator = ","
//      formatter.locale = Locales.vietnam
//      formatter.numberStyle = .currency
//      formatter.positiveFormat = "#,##0 ¤"
//      return formatter.string(from: inputNumber) ?? String(format: "%@%@", AppConstant.Character.space160, symbol)
//    }
}
