//
//  popUpViewController.swift
//  orderProject2
//
//  Created by Phu Vu on 9/6/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol TruyenVeManHinhTable {
    func Truyen(statusOfTable: Bool, ID: Int)
}

class popUpViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableText: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var cancelBookButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    var truyenVeManHinhTable: TruyenVeManHinhTable?
    
    var floorCode: Int!
    var tableCode: Int!
    var tableName: String!
    var imageName: String!
    var message: String!
    var statusOfTable: Bool = true
    var numberOfChair: Int!
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopView() 
        setupImageView()
        setupTableText()
        setupMessageLabel()
        setupBookButton()
        setupCancelBook()
        plusButtonLayer()
        minusButtonLayer()
        ref = Database.database().reference(withPath: "table-items")
        // Do any additional setup after loading the view.
    }
    
    private func setupTopView() {
        topView.layer.cornerRadius = 20
        topView.layer.masksToBounds = true
    }
    
    private func setupImageView() {
        guard let name = imageName else {return}
        if let image = UIImage(named: name) {
            imageView.image = image
        }
    }
    
    private func setupTableText() {
        guard let name  = tableName else {return}
        tableText.text = name
    }
    
    private func setupMessageLabel() {
        guard let text = message else {return}
        messageLabel.text = "Please confirm for table \(text)"
    }
    
    private func setupBookButton() {
        bookButton.layer.cornerRadius = 20
        bookButton.layer.masksToBounds = true
        
    }
    
    private func setupCancelBook() {
        cancelBookButton.layer.cornerRadius = 20
        cancelBookButton.layer.masksToBounds = true
    }
    
    private func plusButtonLayer() {
        plusButton.layer.cornerRadius = 10
        plusButton.layer.borderWidth = 1
        plusButton.layer.borderColor = UIColor.blue.cgColor
    }
    
    private func minusButtonLayer() {
        minusButton.layer.cornerRadius = 10
        minusButton.layer.borderWidth = 1
        minusButton.layer.borderColor = UIColor.blue.cgColor
    }
    
    @IBAction func bookAction(_ sender: Any) {
        statusOfTable = true
        truyenVeManHinhTable?.Truyen(statusOfTable: statusOfTable, ID: tableCode)
        let tableItem = TableItem(floorCode: floorCode, tableCode: tableCode, tableName: tableName, tableImage: imageName, statusOfTable: statusOfTable, numberOfChair: numberOfChair)
        let tableItemRef = self.ref.child("\(tableCode!)")
        tableItemRef.setValue([ "floor" : tableItem.floorCode,"name" : tableItem.tableName, "image" :  tableItem.tableImage, "status" : tableItem.statusOfTable, "chairs" : tableItem.numberOfChair])
        
        
        dismiss(animated: true, completion: nil)
        ProgressHUD.showSuccess("Book Successful")
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        statusOfTable = false
        truyenVeManHinhTable?.Truyen(statusOfTable: statusOfTable, ID: tableCode)
        let tableItem = TableItem(floorCode: floorCode, tableCode: tableCode, tableName: tableName, tableImage: imageName, statusOfTable: statusOfTable, numberOfChair: numberOfChair)
        let tableItemRef = self.ref.child("\(tableCode!)")
        tableItemRef.setValue([ "floor" : tableItem.floorCode,"name" : tableItem.tableName, "image" :  tableItem.tableImage, "status" : tableItem.statusOfTable, "chairs" : tableItem.numberOfChair])
        
        dismiss(animated: true, completion: nil)
        ProgressHUD.showError("Book Cancel")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
