//
//  ViewController.swift
//  orderProject2
//
//  Created by Phu Vu on 9/5/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import UIKit

struct floorItem {
    var floorLabelName: String
}

class TableViewController: UIViewController, TruyenVeManHinhTable, TableCallback {
    
    //TableCallBack
    func onDataUpdate() {
        myTable = tableItemUtils.searchFloor(floorCodeInput: floorCode)
        soBan = myTable.count
        tableCollectionView.reloadData()
    }
    
    //TruyenVeManHinhTable
    func Truyen(statusOfTable: Int, ID: Int, people: Int) {
        let ban = tableItemUtils.getSelectedTable(selectedTable: ID)
        if ban != nil {
            ban?.numberOfPeople = people
            ban?.statusOfTable = statusOfTable
            tableCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var floorCollectionView: UICollectionView!
    @IBOutlet weak var tableCollectionView: UICollectionView!
    
    var tableItemUtils = TableUtils()
    
    var floorItems: [floorItem] = [
        floorItem(floorLabelName: "Tang tret"),
        floorItem(floorLabelName: "Tang 1"),
        floorItem(floorLabelName: "Tang 2"),
        floorItem(floorLabelName: "Tang 3"),
        floorItem(floorLabelName: "Tang 4")
    ]
    
    var tableItems = [TableItem]()
    //var tableItems = [tableItem(tableImageName: "TwoSeatsTable", tableLabelName: "A1")
    //]
    
    var floorCollectionViewFlowLayout: UICollectionViewFlowLayout!
    let floorCellIdentifier = "floorCollectionViewCell"
    
    var tableCollectionViewFlowLayout: UICollectionViewFlowLayout!
    let tableCellIdentifier = "tableCollectionViewCell"
    
    let viewImageSegueIdentifier = "viewImageSegueIdentifier"
    
    var floorCodeInput: Int = 0
    var myTable = [TableItem]()
    var soBan: Int = 0
    var floorCode: Int = 0
    
    var selectedIndexPath: IndexPath? {
        didSet {
            tableCollectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableItemUtils.dumpData()
        tableItemUtils.tableListening(callback: self)
        //tableItems = tableItemUtils.getArrayOfData()
        
        setupFloorCollectionView()
        setupTableCollectionView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupFloorViewItemSize()
        setupTableViewItemSize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = sender as! TableItem
        if segue.identifier == viewImageSegueIdentifier {
            if let vc = segue.destination as? popUpViewController {
                vc.floorCode = item.floorCode
                vc.imageName = item.tableImage
                vc.tableName = item.tableName
                vc.message = item.tableName
                vc.tableCode = item.tableCode
                vc.statusOfTable = item.statusOfTable
                vc.numberOfChair = item.numberOfChair
                vc.numberOfPeople = item.numberOfPeople
            }
        }
        
        if let popUpViewController = segue.destination as? popUpViewController {
            popUpViewController.truyenVeManHinhTable = self
        }
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
            //print("So luong tang \(floorItems.count)")
            return floorItems.count
        } else {
            //print("So luong table \(soBan)")
            return soBan
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.floorCollectionView {
            let floorCell = collectionView.dequeueReusableCell(withReuseIdentifier: floorCellIdentifier, for: indexPath) as! floorCollectionViewCell
            floorCell.floorLabel.text = floorItems[indexPath.item].floorLabelName
            return floorCell
        } else {
            let tableCell = collectionView.dequeueReusableCell(withReuseIdentifier: tableCellIdentifier, for: indexPath) as! tableCollectionViewCell
            tableCell.tableLabel.text = myTable[indexPath.item].tableName
            tableCell.tableImageView.image = UIImage(named: myTable[indexPath.item].tableImage!)
            tableCell.chairLabel.text = "\(myTable[indexPath.item].numberOfPeople!)/\(myTable[indexPath.item].numberOfChair!)"
            
            var borderColor: CGColor! = UIColor.clear.cgColor
            var borderWidth: CGFloat = 0
            
            if myTable[indexPath.item].statusOfTable == 0 {
                borderColor = UIColor.clear.cgColor
                borderWidth = 0
            } else if myTable[indexPath.item].statusOfTable == 1 {
                borderColor = UIColor.red.cgColor
                borderWidth = 3
            } else if myTable[indexPath.item].statusOfTable == 2 {
                borderColor = UIColor.green.cgColor
                borderWidth = 3
            } else if myTable[indexPath.item].statusOfTable == 3 {
                borderColor = UIColor.blue.cgColor
                borderWidth = 3
            }
            
            tableCell.layer.borderWidth = borderWidth
            tableCell.layer.borderColor = borderColor
            
            return tableCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.floorCollectionView {
            floorCode = indexPath.row
            myTable = tableItemUtils.searchFloor(floorCodeInput: floorCode)
            soBan = myTable.count
            tableCollectionView.reloadData()
        } else {
            let tableArray = tableItemUtils.searchFloor(floorCodeInput: floorCode)
            let item = tableArray[indexPath.row]
            selectedIndexPath = indexPath
            performSegue(withIdentifier: viewImageSegueIdentifier, sender: item)
            tableCollectionView.reloadData()
        }
    }
    
    
    
}

