//
//  popUpUtilsViewController.swift
//  OrderNow
//
//  Created by Phu Vu on 11/3/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class popUpUtilsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func orderFoodButton(_ sender: Any) {
        var datMon = HomePageController()
        self.present(datMon, animated: true, completion: nil)
    }
    
    @IBAction func moneyButton(_ sender: Any) {
        var billPay = BillPayViewController()
        present(billPay, animated: true, completion: nil)
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
