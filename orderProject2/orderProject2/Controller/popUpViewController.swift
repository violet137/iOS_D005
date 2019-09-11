//
//  popUpViewController.swift
//  orderProject2
//
//  Created by Phu Vu on 9/6/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import UIKit

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
    
    var imageName: String!
    var tableName: String!
    var tableCode: Int!
    var message: String!
    
    var truyenVeManHinhTable: TruyenVeManHinhTable?
    var statusOfTable: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopView() 
        setupImageView()
        setupTableText()
        setupMessageLabel()
        setupBookButton()
        setupCancelBook()
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
    
    @IBAction func bookAction(_ sender: Any) {
        statusOfTable = true
        
        truyenVeManHinhTable?.Truyen(statusOfTable: statusOfTable, ID: tableCode)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        statusOfTable = false
        truyenVeManHinhTable?.Truyen(statusOfTable: statusOfTable, ID: tableCode)
        dismiss(animated: true, completion: nil)
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
