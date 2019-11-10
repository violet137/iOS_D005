//
//  popUpUtilsViewController.swift
//  OrderNow
//
//  Created by Phu Vu on 11/3/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class popUpUtilsViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var moneyButton: UIButton!
    
    private func setupTopView() {
        topView.layer.cornerRadius = 20
        topView.layer.masksToBounds = true
    }
    
    private func setupOrderButton() {
        orderButton.layer.cornerRadius = 20
        orderButton.layer.masksToBounds = true
        orderButton.layer.borderColor = UIColor.black.cgColor
        orderButton.layer.borderWidth = 1
        
    }
    
    private func setupMoneyButton() {
        moneyButton.layer.cornerRadius = 20
        moneyButton.layer.masksToBounds = true
        moneyButton.layer.borderColor = UIColor.black.cgColor
        moneyButton.layer.borderWidth = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTopView()
        setupOrderButton()
        setupMoneyButton()
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func orderFoodButton(_ sender: Any) {
        var datMon = HomePageController()
        self.present(datMon, animated: true, completion: nil)
    }
    
    @IBAction func moneyButton(_ sender: Any) {
        var billPay = BillPayViewController()
        self.present(billPay, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
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
