//
//  HomePageController.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 8/24/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import GoogleSignIn
import SnapKit

class HomePageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, sentUserInfo {
    // protocol func
    func sentData(user: GIDGoogleUser) {
        self.user = user
    }

    // outlet
    @IBOutlet weak var listFoodCollectionView: UICollectionView!
    @IBOutlet weak var tabBarCollectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var searchBt: UIButton!
    @IBOutlet weak var backBt: UIButton!
    @IBOutlet weak var UserImg: UIImageView!
    @IBOutlet weak var nameUser: UIButton!
    @IBOutlet weak var stackViewUser: UIStackView!
    
    //variable blabla....
    var number = 15
    var user: GIDGoogleUser?
    var numberOfItem = [15,3,5,6,7,4]
    let loginController = LoginController()
    let popUpView = UIView()
    let blurBlackView = UIView()
    var searchBar = UISearchBar()
    var cancelBt = UIButton()
    let coverVw = UIView()
        // các thành phần trong Popup
        let popupImg = UIImageView()
        let popupFoodNameLb = UILabel()
        let costLb = UILabel()
        let moreBt = UIButton()
        let lessBt = UIButton()
        let amountLb = UILabel()
        let addToBillBt = UIButton()
        let cancelPopupBt = UIButton()
    
    //Viewdidload func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginController.delegate = self
        setUpSomethingElse()
        setUpContraintNavigationBar()
        conectCollectionView()
        setUpPopUp()
        makeContraintInPopupView()
    }
    
    //contraint các thứ
    
        //Và đây là contraint PopupView
    
        func setUpContraintPopUp(){
            
            blurBlackView.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
            
            popUpView.snp.makeConstraints { (make) in
                make.center.equalTo(self.view.snp.center)
                make.width.equalTo(self.view.snp.width).dividedBy(1.35)
                make.height.equalTo(self.view.snp.height).dividedBy(2)
            }
        }
    
        //Và đây là contraint các thứ trong popupView
    
        func makeContraintInPopupView(){
            popUpView.addSubview(popupImg)
            popUpView.addSubview(popupFoodNameLb)
            popUpView.addSubview(costLb)
            popUpView.addSubview(moreBt)
            popUpView.addSubview(lessBt)
            popUpView.addSubview(amountLb)
            popUpView.addSubview(addToBillBt)
            popUpView.addSubview(cancelPopupBt)
            
            popupImg.image = UIImage(named: "tomhum")
            popupImg.contentMode = .scaleAspectFit
            popupImg.snp.makeConstraints { (make) in
                make.top.equalTo(self.popUpView.snp.top).inset(5)
                make.leading.equalTo(self.popUpView.snp.leading)
                make.trailing.equalTo(self.popUpView.snp.trailing)
                make.height.equalTo(popUpView.snp.height).dividedBy(2)
            }
            
            
            popupFoodNameLb.font = UIFont.boldSystemFont(ofSize: 18)
            popupFoodNameLb.textAlignment = .center
            popupFoodNameLb.numberOfLines = 0
            popupFoodNameLb.snp.makeConstraints { (make) in
                make.top.equalTo(self.popupImg.snp.bottom)
                make.leading.trailing.equalTo(self.popUpView)
                make.height.equalTo(self.view.snp.height).dividedBy(12)
            }
            
            
            costLb.textAlignment = .center
            costLb.snp.makeConstraints { (make) in
                make.top.equalTo(popupFoodNameLb.snp.bottom)
                make.leading.equalTo(popUpView)
                make.width.equalTo(popUpView.snp.width).dividedBy(2)
                make.height.equalTo(self.view.snp.height).dividedBy(12)
            }
            
            
            popUpView.addSubview(coverVw)
            coverVw.snp.makeConstraints { (make) in
                make.trailing.equalTo(popUpView)
                make.centerY.equalTo(costLb.snp.centerY)
                make.height.equalTo(costLb)
                make.leading.equalTo(costLb.snp.trailing)
            }
            
            coverVw.addSubview(amountLb)
            
            amountLb.textAlignment = .center
            amountLb.snp.makeConstraints { (make) in
                make.center.equalTo(coverVw)
                make.width.equalTo(30)
                make.height.equalTo(30)
            }
            
            coverVw.addSubview(moreBt)
            moreBt.setBackgroundImage(UIImage.init(named: "cong"), for: .normal)
            moreBt.snp.makeConstraints { (make) in
                make.leading.equalTo(amountLb.snp.trailing)
                make.width.equalTo(25)
                make.height.equalTo(25)
                make.centerY.equalTo(amountLb)
            }
            
            coverVw.addSubview(lessBt)
            lessBt.setBackgroundImage(UIImage.init(named: "tru"), for: .normal)
            lessBt.snp.makeConstraints { (make) in
                make.centerY.equalTo(amountLb)
                make.height.equalTo(25)
                make.width.equalTo(25)
                make.trailing.equalTo(amountLb.snp.leading)
            }
            
            let coverVw2 = UIView()
            popUpView.addSubview(coverVw2)
            coverVw2.snp.makeConstraints { (make) in
                make.top.equalTo(costLb.snp.bottom)
                make.bottom.equalTo(popUpView.snp.bottom)
                make.leading.trailing.equalTo(popUpView)
            }
            
            coverVw2.addSubview(cancelPopupBt)
            cancelPopupBt.backgroundColor = .red
            cancelPopupBt.layer.cornerRadius = 5.0
            cancelPopupBt.setTitle("Cancel", for: .normal)
            cancelPopupBt.snp.makeConstraints { (make) in
                make.centerX.equalTo(costLb.snp.centerX)
                make.centerY.equalTo(coverVw2.snp.centerY)
                make.width.equalTo(costLb).dividedBy(1.05)
            }
            
            coverVw2.addSubview(addToBillBt)
            addToBillBt.setTitle("Add to Bill", for: .normal)
            addToBillBt.layer.cornerRadius = 5.0
            addToBillBt.backgroundColor = UIColor.rgb(r: 50, g: 205, b: 50, a: 1)
            addToBillBt.snp.makeConstraints { (make) in
                make.centerY.equalTo(cancelPopupBt)
                make.centerX.equalTo(coverVw)
                make.width.equalTo(cancelPopupBt)
            }
            
            // các tính năng của các nút
            
            cancelPopupBt.addTarget(self, action: #selector(handleCancelPopupBt), for: .touchUpInside)
            addToBillBt.addTarget(self, action: #selector(handleAddToBillBt), for: .touchUpInside)
            moreBt.addTarget(self, action: #selector(handleMoreBt), for: .touchUpInside)
            lessBt.addTarget(self, action: #selector(handleLessBt), for: .touchUpInside)
        }
    
    //Và đây là tính năng TRONG popUp
    
    @objc func handleCancelPopupBt(){
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseOut, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            self.popUpIsClose(status: true)
        }
        UIButton.animate(withDuration: 0.25, animations: {
            self.cancelPopupBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            if finished{
                self.cancelPopupBt.transform = CGAffineTransform.identity
            }
        }
    }
    
    @objc func handleAddToBillBt(){
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseOut, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            self.popUpIsClose(status: true)
        }
        UIButton.animate(withDuration: 0.25, animations: {
            self.addToBillBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            if finished{
                self.addToBillBt.transform = CGAffineTransform.identity
            }
        }
        // do something else
    }
    
    @objc func handleMoreBt(){
        if amount >= 0 && amount < 10{
            amount += 1
            self.amountLb.text = "\(self.amount)"
            costLb.text = "\(amount*85000) đ"
        }
    }
    
    var amount = 1
    
    @objc func handleLessBt(){
        if amount > 0 && amount <= 10{
            amount -= 1
            amountLb.text = "\(amount)"
            costLb.text = "\(amount*85000) đ"
        }
    }
    
    // Và đây là tính năng CỦA popup
    
    fileprivate func setUpPopUp() {
        self.view.addSubview(blurBlackView)
        self.view.addSubview(popUpView)
        setUpContraintPopUp()
        popUpIsClose(status: true)
        blurBlackView.backgroundColor = UIColor.rgb(r: 0, g: 0, b: 0, a: 0.5)
        popUpView.backgroundColor = .white
        blurBlackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancelPopup)))
        popUpView.layer.cornerRadius = 10
    }
    
    @objc func handleCancelPopup(){
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseOut, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            self.popUpIsClose(status: true)
        }
    }
    
    //Hàm kiểm tra trạng thái xuất hiện của popupView
    fileprivate func popUpIsClose(status: Bool) {
        popUpView.isHidden = status
        blurBlackView.isHidden = status
        UIView.animate(withDuration: 0.3, delay: 0.005, options: .curveEaseOut, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (finished: Bool) in
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    
        //Và đây là contraint của navigationBar
    
        func setUpContraintNavigationBar(){
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
    
    //Và đây là một vaì setup blablabla.... của navigtionBar
    func setUpSomethingElse(){
        
        searchBar.barStyle = .blackOpaque
        self.searchBar.transform = CGAffineTransform(translationX: 0, y: -40)
        self.cancelBt.transform = CGAffineTransform(translationX: 100, y: 0)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        cancelBt.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(searchBar)
        navigationBar.addSubview(searchBt)
        navigationBar.addSubview(cancelBt)
        //        searchBar.isHidden = true
        //        cancelBt.isHidden = true
        cancelBt.addTarget(self, action: #selector(handleCancel)
            , for: .touchUpInside)
        searchBar.isHidden = true
        cancelBt.isHidden = true
        // login user trên navigation bar
        nameUser.setTitle(user?.profile.name ?? "Tài Khoản", for: .normal)
    }
    
        // Và đây là setup tính năng các nút trong navigationbar
        @IBAction func searchAct(_ sender: Any) {
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(handleSeclectSearch), userInfo: nil, repeats: false)
        }
    
        @objc func handleSeclectSearch(){
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    self.searchBar.transform = CGAffineTransform.identity
                    self.cancelBt.transform = CGAffineTransform.identity
                })
                self.setUpHiddenOrNot(Bool: false)
                self.setUpContraintNavigationBar()
            }
        }
    
        func setUpHiddenOrNot(Bool: Bool){
            self.backBt.isHidden = !Bool
            self.searchBt.isHidden = !Bool
            self.searchBar.isHidden = Bool
            self.cancelBt.isHidden = Bool
            self.stackViewUser.isHidden = !Bool
        }
    
        @objc func handleSelectorCancel(){
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, delay: 0.005, options: .curveEaseOut, animations: {
                    self.searchBar.transform = CGAffineTransform(translationX: 0, y: -40)
                    self.cancelBt.transform = CGAffineTransform(translationX: 100, y: 0)
                }, completion: { (finish: Bool) in
                    if finish{
                        self.setUpHiddenOrNot(Bool: true)
                        self.setUpContraintNavigationBar()
                    }
                })
                
            }
        }
    
        @objc func handleCancel(){
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(handleSelectorCancel), userInfo: nil, repeats: false)
        }
    
        @IBAction func nameUserAct(_ sender: Any) {
        }
    
        @IBAction func tapToImgUserAct(_ sender: Any) {
        }
    
    //Và đây là hàm dùng để kết nối collectionView
    
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
    // tất cả mọi thứ về collectionview collection view
    
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
            return 6
        }else{
            return number
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
                cell.setUpcell(data: (Any).self)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabBarCollectionView{
                number = numberOfItem[indexPath.item]
                listFoodCollectionView.reloadData()
        }else{
            popUpIsClose(status: false)
            amountLb.text = String(amount)
            popupFoodNameLb.text = "Tôm hùm nướng, rưới sốt bơ chanh tỏi"
            costLb.text = "85000 đ"
        }
    }
}

// extend lại cho dễ dùng :))
extension UIColor {
    static func rgb(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}


