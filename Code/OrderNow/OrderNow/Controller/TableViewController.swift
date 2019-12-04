//
//  ViewController.swift
//  orderProject2
//
//  Created by Phu Vu on 9/5/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct floorItem {
    var floorLabelName: String
}

//protocol dataPassBillDelegate {
//    func getTable(statusCode: Int, ID: Int)
//}

class TableViewController: UIViewController, TruyenVeManHinhTable, TableCallback {
    func changeStatus(ban: String) {
    }
    
    func truyenTable(statusOfTable: Int, ID: Int) {
    }

    func choXacNhan(ban: TableItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let manHinhPopUp = sb.instantiateViewController(withIdentifier: "popUp") as! popUpViewController
        self.navigationController?.pushViewController(manHinhPopUp, animated: true)
        performSegue(withIdentifier: viewImageSegueIdentifier, sender: ban)
        tableCollectionView.reloadData()
    }
    
    
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
    
//    var dataPassBillDelegate: dataPassBillDelegate?
    var tableItemUtils = TableUtils()
    
    var floorItems: [floorItem] = [
        floorItem(floorLabelName: "Đại sảnh"),
        floorItem(floorLabelName: "Tầng 1"),
        floorItem(floorLabelName: "Tầng 2"),
        floorItem(floorLabelName: "Tầng 3"),
        floorItem(floorLabelName: "Tầng 4")
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
    var ref: DatabaseReference!
    
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
        
        self.view.backgroundColor = .orange
        ref = Database.database().reference(withPath: "table-items")
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
        floorCollectionView.backgroundColor = .orange
    }
    
    private func setupTableCollectionView() {
        tableCollectionView.delegate = self
        tableCollectionView.dataSource = self
        let tableNib = UINib(nibName: "tableCollectionViewCell", bundle: nil)
        tableCollectionView.register(tableNib, forCellWithReuseIdentifier: tableCellIdentifier)
        tableCollectionView.backgroundColor = .orange
        
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

extension TableViewController: UICollectionViewDelegate, UICollectionViewDataSource, TruyenVeManHinhTableTuCollectionViewCell {

    func showAlert(cell: tableCollectionViewCell){
        let indexPath = self.tableCollectionView.indexPath(for: cell)
        
        let tableArray = tableItemUtils.searchFloor(floorCodeInput: floorCode)
        let item = tableArray[(indexPath?.row)!]
        let tableCode = item.tableCode
        let tableItemRef = self.ref.child("\(tableCode!)")
        print("IndexPath: \(indexPath)")
        print("Table Code: \(tableCode!)" )
        print("Floor Code: \(floorCode)")

        let alert = UIAlertController(title: "Bạn muốn huỷ bàn", message: "Xin hãy kiểm tra bàn đã thanh toán chưa?", preferredStyle: .alert)
        var statusOfTable = 0
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            statusOfTable = 0
            //Truyen Ve lai Database
            tableItemRef.setValue([ "floor" : item.floorCode!,"name" : item.tableName!, "image" :  item.tableImage!, "status" : statusOfTable, "people": item.numberOfPeople!, "chairs" : item.numberOfChair!])
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
        }))
        tableCollectionView.reloadData()
        present(alert, animated: true, completion: nil)
        
    }
    
    func showBillPay(cell: tableCollectionViewCell) {
        let indexPath = self.tableCollectionView.indexPath(for: cell)
        let tableArray = tableItemUtils.searchFloor(floorCodeInput: floorCode)
        let item = tableArray[(indexPath?.row)!]
        let statusCode = item.statusOfTable
        let tableID = item.tableCode
        let billPay = BillPayViewController()
        let billPayCell = BillViewCell()
        if(item != nil) {
            billPay.tenBan = item.tableName
            billPay.getTable(statusCode: statusCode!, ID: tableID!)
            present(billPay, animated: true, completion: nil)
        } else { return }
        tableCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.floorCollectionView {
            return floorItems.count
        } else {
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
                tableCell.confirmAction.isHidden = true
                tableCell.billAction.isHidden = true
            } else if myTable[indexPath.item].statusOfTable == 1 {
                borderColor = UIColor.red.cgColor
                borderWidth = 3
                tableCell.confirmAction.isHidden = true
                tableCell.billAction.isHidden = true
            } else if myTable[indexPath.item].statusOfTable == 2 {
                borderColor = UIColor.green.cgColor
                borderWidth = 3
                tableCell.confirmAction.isHidden = false
                tableCell.billAction.isHidden = false
            } else if myTable[indexPath.item].statusOfTable == 3 {
                borderColor = UIColor.blue.cgColor
                borderWidth = 3
                tableCell.confirmAction.isHidden = false
                tableCell.billAction.isHidden = false
            }
            
            tableCell.layer.borderWidth = borderWidth
            tableCell.layer.borderColor = borderColor
            
            //Delegate For Alert Notification
            tableCell.delegate = self
            
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
            //print(indexPath.row)
            selectedIndexPath = indexPath
            if (item.statusOfTable! == 0 || item.statusOfTable! == 1) {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let manHinhPopUp = sb.instantiateViewController(withIdentifier: "popUp") as! popUpViewController
                self.navigationController?.pushViewController(manHinhPopUp, animated: true)
            } else if (item.statusOfTable! == 2 || item.statusOfTable! == 3) {
                var datMon = HomePageController()
                datMon.banid = myTable[indexPath.item].tableName ?? ""
                self.present(datMon, animated: true, completion: nil)
            }
            
            performSegue(withIdentifier: viewImageSegueIdentifier, sender: item)
            tableCollectionView.reloadData()
        }
    }
    
    
    
}

//extension TableViewController: TruyenVeManHinhTableTuCollectionViewCell {

//}

