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
    func Truyen(statusOfTable: Int, ID: Int, people: Int)
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
    @IBOutlet weak var peopleLabel: UILabel!
    var truyenVeManHinhTable: TruyenVeManHinhTable?
    
    var floorCode: Int!
    var tableCode: Int!
    var tableName: String!
    var imageName: String!
    var message: String!
    var statusOfTable: Int!
    var numberOfChair: Int!
    var numberOfPeople: Int! = 0
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
        print(numberOfPeople)
        if statusOfTable == 1 {
            if (numberOfPeople > 0) {
                ProgressHUD.showSuccess("Book Successful")
                statusOfTable = 2
            } else {
                ProgressHUD.showError("Please check again!")
                statusOfTable = 0
            }
        } else {
            if (numberOfPeople > 0) {
                ProgressHUD.showSuccess("Book Successful")
                statusOfTable = 3
            } else {
                ProgressHUD.showError("Please check again!")
                statusOfTable = 0
            }
        }
        truyenVeManHinhTable?.Truyen(statusOfTable: statusOfTable, ID: tableCode, people: numberOfPeople)
        let tableItem = TableItem(floorCode: floorCode, tableCode: tableCode, tableName: tableName, tableImage: imageName, statusOfTable: statusOfTable, numberOfPeople: numberOfPeople, numberOfChair: numberOfChair)
        
        let tableItemRef = self.ref.child("\(tableCode!)")
        tableItemRef.setValue([ "floor" : tableItem.floorCode,"name" : tableItem.tableName, "image" :  tableItem.tableImage, "status" : tableItem.statusOfTable, "people": tableItem.numberOfPeople, "chairs" : tableItem.numberOfChair])
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        statusOfTable = 0
        numberOfPeople = 0
        truyenVeManHinhTable?.Truyen(statusOfTable: statusOfTable, ID: tableCode, people: numberOfPeople)
        let tableItem = TableItem(floorCode: floorCode, tableCode: tableCode, tableName: tableName, tableImage: imageName, statusOfTable: statusOfTable, numberOfPeople: numberOfPeople, numberOfChair: numberOfChair)
        let tableItemRef = self.ref.child("\(tableCode!)")
        tableItemRef.setValue([ "floor" : tableItem.floorCode,"name" : tableItem.tableName, "image" :  tableItem.tableImage, "status" : tableItem.statusOfTable, "people": tableItem.numberOfPeople, "chairs" : tableItem.numberOfChair])
        
        dismiss(animated: true, completion: nil)
        ProgressHUD.showError("Book Cancel")
    }
    
    @IBAction func actionIncrease(_ sender: Any) {
        if numberOfPeople < numberOfChair  {
            numberOfPeople = numberOfPeople + 1
            print(numberOfPeople!)
        }
        peopleLabel.text = "\(numberOfPeople!)"
        let tableItem = TableItem(floorCode: floorCode, tableCode: tableCode, tableName: tableName, tableImage: imageName, statusOfTable: statusOfTable, numberOfPeople: numberOfPeople, numberOfChair: numberOfChair)
        let tableItemRef = self.ref.child("\(tableCode!)")
        tableItemRef.setValue([ "floor" : tableItem.floorCode,"name" : tableItem.tableName, "image" :  tableItem.tableImage, "status" : tableItem.statusOfTable, "people": tableItem.numberOfPeople, "chairs" : tableItem.numberOfChair])
    }
    
    @IBAction func actionDecrease(_ sender: Any) {
        if numberOfPeople > 0 {
            numberOfPeople = numberOfPeople - 1
            print(numberOfPeople!)
        }
        peopleLabel.text = "\(numberOfPeople!)"
        let tableItem = TableItem(floorCode: floorCode, tableCode: tableCode, tableName: tableName, tableImage: imageName, statusOfTable: statusOfTable, numberOfPeople: numberOfPeople, numberOfChair: numberOfChair)
        let tableItemRef = self.ref.child("\(tableCode!)")
        tableItemRef.setValue([ "floor" : tableItem.floorCode,"name" : tableItem.tableName, "image" :  tableItem.tableImage, "status" : tableItem.statusOfTable, "people": tableItem.numberOfPeople, "chairs" : tableItem.numberOfChair])
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
