//
//  HomePageController.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 8/24/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    var searchBar = UISearchBar()
    @IBOutlet weak var searchBt: UIButton!
    @IBOutlet weak var backBt: UIButton!
    var cancelBt = UIButton()
    @IBOutlet weak var UserImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        cancelBt.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(searchBar)
        navigationBar.addSubview(searchBt)
        navigationBar.addSubview(cancelBt)
        setUpContraint()
        searchBar.isHidden = true
        cancelBt.isHidden = true
        cancelBt.addTarget(self, action: #selector(handleCancel)
            , for: .touchUpInside)
    }
    
    func setUpContraint(){
        NSLayoutConstraint(item: searchBar, attribute: .leading, relatedBy: .equal, toItem: navigationBar, attribute: .leading, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: searchBar, attribute: .centerY, relatedBy: .equal, toItem: navigationBar, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: searchBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: cancelBt, attribute: .centerY, relatedBy: .equal, toItem: navigationBar, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: cancelBt, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint(item: cancelBt, attribute: .leading, relatedBy: .equal, toItem: searchBar, attribute: .trailing, multiplier: 1.0, constant: 5).isActive = true
        searchBar.placeholder = "Tìm Kiếm"
        cancelBt.setTitle("Cancel", for: .normal)
        cancelBt.contentVerticalAlignment = .center
        cancelBt.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func searchAct(_ sender: Any) {
        DispatchQueue.main.async {
            self.setUpTF(Bool: false)
        }
    }
    
    func setUpTF(Bool: Bool){
        self.backBt.isHidden = !Bool
        self.searchBt.isHidden = !Bool
        self.searchBar.isHidden = Bool
        self.cancelBt.isHidden = Bool
    }
    
    @objc func handleCancel(){
        DispatchQueue.main.async {
            self.setUpTF(Bool: true)
        }
    }
    @IBAction func nameUserAct(_ sender: Any) {
    }
    @IBAction func tapToImgUserAct(_ sender: Any) {
    }
    
}

