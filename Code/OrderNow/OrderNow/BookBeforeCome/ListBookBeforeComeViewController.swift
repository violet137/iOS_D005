//
//  OrderBeforeComeViewController.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 11/1/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import SnapKit


class ListBookBeforeComeViewController: UIViewController {
    
    var titleBarLb = UILabel()
    
    lazy var listBooking: ListBookingTableView = {
        let lb = ListBookingTableView()
        lb.bookBFCVC = self
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showSpinner(onView: self.view)
        setupInterface()
        setupContraintTBV()
    }
    
    func setupContraintTBV(){
        self.view.addSubview(listBooking)
        listBooking.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    func setupInterface(){
        self.view.backgroundColor = .white
        navigationController?.navigationBar.addSubview(titleBarLb)
        titleBarLb.text = "Đặt Trước"
        titleBarLb.snp.makeConstraints { (make) in
            make.center.equalTo((navigationController?.navigationBar.snp.center)!)
        }
    }
    
}

// tạo hiệu ứng loading data
var spinner: UIView?
extension UIViewController{
    
    func showSpinner(onView: UIView){
        let spinnerVw = UIView(frame: onView.bounds)
        spinnerVw.backgroundColor = UIColor.rgb(r: 0.5, g: 0.5, b: 0.5, a: 0.5)
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerVw.center
        
        DispatchQueue.main.async {

            spinnerVw.addSubview(ai)
            onView.addSubview(spinnerVw)
        }
        spinner = spinnerVw
    }
    
    func removeSpinner(){
        DispatchQueue.main.async {
            spinner?.removeFromSuperview()
            spinner = nil
        }
    }
    
}
