//
//  ViewController.swift
//  orderProject2
//
//  Created by Phu Vu on 9/5/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import UIKit

struct tableItem{
    var tableImageName: String
    var tableLabelName: String
}

struct floorItem {
    var floorLabelName: String
}

class TableViewController: UIViewController {
    @IBOutlet weak var floorCollectionView: UICollectionView!
    @IBOutlet weak var tableCollectionView: UICollectionView!
    
    var floorItems: [floorItem] = [
        floorItem(floorLabelName: "Tang tret"),
        floorItem(floorLabelName: "Tang 1"),
        floorItem(floorLabelName: "Tang 2"),
        floorItem(floorLabelName: "Tang 3"),
        floorItem(floorLabelName: "Tang 4")
    ]
    
    var tableItems: [tableItem] = [
        tableItem(tableImageName: "TwoSeatsTable", tableLabelName: "A001-1"),
        tableItem(tableImageName: "TwoSeatsTable", tableLabelName: "A001-2"),
        tableItem(tableImageName: "TwoSeatsTable", tableLabelName: "A001-3"),

        tableItem(tableImageName: "FourSeatsTable", tableLabelName: "A001-4"),
        tableItem(tableImageName: "FourSeatsTable", tableLabelName: "A001-5"),
        tableItem(tableImageName: "FourSeatsTable", tableLabelName: "A001-6"),

        tableItem(tableImageName: "SixSeatsTable", tableLabelName: "A001-7"),
        tableItem(tableImageName: "SixSeatsTable", tableLabelName: "A001-8"),
        tableItem(tableImageName: "SixSeatsTable", tableLabelName: "A001-9"),

        tableItem(tableImageName: "TwoSeatsTable", tableLabelName: "A001-10"),
        tableItem(tableImageName: "TwoSeatsTable", tableLabelName: "A001-11"),
        tableItem(tableImageName: "TwoSeatsTable", tableLabelName: "A001-12"),
    ]
    
    var floorCollectionViewFlowLayout: UICollectionViewFlowLayout!
    let floorCellIdentifier = "floorCollectionViewCell"
    
    var tableCollectionViewFlowLayout: UICollectionViewFlowLayout!
    let tableCellIdentifier = "tableCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFloorCollectionView()
        setupTableCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupFloorViewItemSize()
        setupTableViewItemSize()
    }
    
    private func setupFloorCollectionView() {
        floorCollectionView.delegate = self
        floorCollectionView.dataSource = self
        let floorNib = UINib(nibName: "floorCollectionViewCell", bundle: nil)
        floorCollectionView.register(floorNib, forCellWithReuseIdentifier: floorCellIdentifier)
        floorCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupTableCollectionView() {
        tableCollectionView.delegate = self
        tableCollectionView.dataSource = self
        let tableNib = UINib(nibName: "tableCollectionViewCell", bundle: nil)
        tableCollectionView.register(tableNib, forCellWithReuseIdentifier: tableCellIdentifier)
    }
    
    private func setupFloorViewItemSize() {
        if floorCollectionViewFlowLayout == nil {
            let interItemSpacing: CGFloat = 0
            let width = floorCollectionView.frame.width / 4
            let height = floorCollectionView.frame.height
            
            floorCollectionViewFlowLayout = UICollectionViewFlowLayout()
            floorCollectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            floorCollectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            floorCollectionViewFlowLayout.scrollDirection = .horizontal
            floorCollectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            floorCollectionView.setCollectionViewLayout(floorCollectionViewFlowLayout, animated: true)
        }
    }
    
    private func setupTableViewItemSize() {
        if tableCollectionViewFlowLayout == nil {
            let numberOfItemPerRow: CGFloat = 3
            let lineSpacing: CGFloat = 20
            let interItemSpacing: CGFloat = 10

            let width = (tableCollectionView.frame.width - (numberOfItemPerRow - 1) * interItemSpacing) / numberOfItemPerRow
            let height = width

            tableCollectionViewFlowLayout = UICollectionViewFlowLayout()
            tableCollectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            tableCollectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            tableCollectionViewFlowLayout.scrollDirection = .vertical
            tableCollectionViewFlowLayout.minimumLineSpacing = lineSpacing
            tableCollectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing

            tableCollectionView.setCollectionViewLayout(tableCollectionViewFlowLayout, animated: true)
        }
    }
}

extension TableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.floorCollectionView {
            return floorItems.count
        } else {
            return tableItems.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.floorCollectionView {
            let floorCell = collectionView.dequeueReusableCell(withReuseIdentifier: floorCellIdentifier, for: indexPath) as! floorCollectionViewCell
            floorCell.floorLabel.text = floorItems[indexPath.item].floorLabelName
            return floorCell
        } else {
            let tableCell = collectionView.dequeueReusableCell(withReuseIdentifier: tableCellIdentifier, for: indexPath) as! tableCollectionViewCell
            tableCell.tableImageView.image = UIImage(named: tableItems[indexPath.item].tableImageName)
            tableCell.tableLabel.text = tableItems[indexPath.item].tableLabelName
            return tableCell
        }
    }
        
//        let floorCell = floorCollectionView.dequeueReusableCell(withReuseIdentifier: floorCellIdentifier, for: indexPath) as! floorCollectionViewCell
//        floorCell.floorLabel.text = floorItems[indexPath.item].floorLabelName
//        return floorCell
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.floorCollectionView {
            print("select floor: \(indexPath)")
        } else {
            print("select table: \(indexPath)")
        }
    }
    
    
}

