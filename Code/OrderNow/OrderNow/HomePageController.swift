//
//  HomePageController.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 8/24/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class HomePageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var listFoodCollectionView: UICollectionView!
    @IBOutlet weak var tabBarCollectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    var searchBar = UISearchBar()
    @IBOutlet weak var searchBt: UIButton!
    @IBOutlet weak var backBt: UIButton!
    var cancelBt = UIButton()
    @IBOutlet weak var UserImg: UIImageView!
    @IBOutlet weak var stackViewUser: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSomethingElse()
        setUpContraint()
        conectCollectionView()
    }
    
    func conectCollectionView(){
        listFoodCollectionView.delegate = self
        listFoodCollectionView.dataSource = self
        tabBarCollectionView.delegate = self
        tabBarCollectionView.dataSource = self
        tabBarCollectionView.register(UINib(nibName: "TabBarViewCell", bundle: nil), forCellWithReuseIdentifier: "tabbartop")
        listFoodCollectionView.register(UINib(nibName: "ListFoodViewCell", bundle: nil), forCellWithReuseIdentifier: "listfood")
        let indexPath = NSIndexPath(item: 0, section: 0)
        tabBarCollectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .init())
    }
    
    func setUpSomethingElse(){
        
        searchBar.barStyle = .blackOpaque
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        cancelBt.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(searchBar)
        navigationBar.addSubview(searchBt)
        navigationBar.addSubview(cancelBt)
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
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(handleSelector), userInfo: nil, repeats: false)
    }
    
    @objc func handleSelector(){
        setUpTF(Bool: false)
    }
    
    func setUpTF(Bool: Bool){
            self.backBt.isHidden = !Bool
            self.searchBt.isHidden = !Bool
            self.searchBar.isHidden = Bool
            self.cancelBt.isHidden = Bool
            self.stackViewUser.isHidden = !Bool
    }
    
    @objc func handleSelectorCancel(){
        setUpTF(Bool: true)
    }
    
    @objc func handleCancel(){
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(handleSelectorCancel), userInfo: nil, repeats: false)
    }
    @IBAction func nameUserAct(_ sender: Any) {
    }
    @IBAction func tapToImgUserAct(_ sender: Any) {
    }
    
    // collection view
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        if collectionView == tabBarCollectionView{
            layout?.minimumLineSpacing = 20.0
            layout?.sectionInset = UIEdgeInsets(top: 0, left: 25.0, bottom:  0, right: 0)
            return CGSize(width: self.tabBarCollectionView.frame.width / 3, height: 45)
        }else{
            layout?.minimumLineSpacing = 20.0
            layout?.minimumInteritemSpacing = 10.0
            return CGSize(width: (self.listFoodCollectionView.frame.width / 2) - 10, height: (self.listFoodCollectionView.frame.height / 3) - 20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabBarCollectionView{
            
            return 8
        }else{
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabBarCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabbartop", for: indexPath) as? TabBarViewCell else {
                return UICollectionViewCell()
            }
            DispatchQueue.main.async {
                cell.setUpCell()
            }
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listfood", for: indexPath) as? ListFoodViewCell else{
                return UICollectionViewCell()
            }
            DispatchQueue.main.async {
                cell.setUpcell()
            }
            return cell
        }
    }
    
}

