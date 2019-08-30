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
    
    func sentData(user: GIDGoogleUser) {
        self.user = user
    }
    
    @IBOutlet weak var listFoodCollectionView: UICollectionView!
    @IBOutlet weak var tabBarCollectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    var searchBar = UISearchBar()
    @IBOutlet weak var searchBt: UIButton!
    @IBOutlet weak var backBt: UIButton!
    var cancelBt = UIButton()
    @IBOutlet weak var UserImg: UIImageView!
    @IBOutlet weak var nameUser: UIButton!
    @IBOutlet weak var stackViewUser: UIStackView!
    var number = 15
    var user: GIDGoogleUser?
    var index = [0,1,2,3,4,5]
    var numberOfItem = [15,3,5,6,7,4]
    let loginController = LoginController()
    
    let popUpView = UIView()
    let blurBlackView = UIView()
    
    fileprivate func setStatusPopup(status: Bool) {
        popUpView.isHidden = status
        blurBlackView.isHidden = status
        UIView.animate(withDuration: 0.3, delay: 0.005, options: [], animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (finished: Bool) in
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    
    fileprivate func setUpPopUp() {
        self.view.addSubview(blurBlackView)
        self.view.addSubview(popUpView)
        setUpContraintPopUp()
        setStatusPopup(status: true)
        blurBlackView.backgroundColor = UIColor.rgb(r: 0, g: 0, b: 0, a: 0.5)
        popUpView.backgroundColor = .white
        blurBlackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelPopup)))
        popUpView.layer.cornerRadius = 10
    }
    
    @objc func cancelPopup(){
        UIView.animate(withDuration: 0.25, delay: 0.05, options: [], animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            self.setStatusPopup(status: true)
        }
    }
    // các thành phần trong Popup
    let popupImg = UIImageView()
    let popupFoodNameLb = UILabel()
    let costLb = UILabel()
    let moreBt = UIButton()
    let lessBt = UIButton()
    let amountLb = UILabel()
    let addToBillBt = UIButton()
    let cancelPopupBt = UIButton()
    let stackMoreAndLessView = UIStackView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupImg.image = UIImage(named: "tomhum")
        popupImg.contentMode = .scaleAspectFit
        loginController.delegate = self
        setUpSomethingElse()
        setUpContraint()
        conectCollectionView()
        setUpPopUp()
        makeContraintInPopupView()
    }
    
    func makeContraintInPopupView(){
        popUpView.addSubview(popupImg)
        popUpView.addSubview(popupFoodNameLb)
        popUpView.addSubview(costLb)
        popUpView.addSubview(stackMoreAndLessView)
        stackMoreAndLessView.addArrangedSubview(moreBt)
        stackMoreAndLessView.addArrangedSubview(lessBt)
        stackMoreAndLessView.addArrangedSubview(amountLb)
        popUpView.addSubview(addToBillBt)
        popUpView.addSubview(cancelPopupBt)
        
        popupImg.snp.makeConstraints { (make) in
//            make.top.equalTo(self.popUpView.snp.top).inset(5)
//            make.leading.equalTo(self.popUpView.snp.leading)
//            make.trailing.equalTo(self.popUpView.snp.trailing)
//            make.height.equalTo(self.popUpView.frame.height / 2)
        }
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
        self.searchBar.transform = CGAffineTransform(translationX: 0, y: -100)
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
    // contraint sau khi nhấn nút
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
    // contraint đầu tiên của searchbar và nút cancel
    
    @IBAction func searchAct(_ sender: Any) {
        Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(handleSelector), userInfo: nil, repeats: false)
    }
    
    @objc func handleSelector(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                self.searchBar.transform = CGAffineTransform.identity
                self.cancelBt.transform = CGAffineTransform.identity
            })
            self.setUpTF(Bool: false)
            self.setUpContraint()
        }
    }
    
    func setUpTF(Bool: Bool){
            self.backBt.isHidden = !Bool
            self.searchBt.isHidden = !Bool
            self.searchBar.isHidden = Bool
            self.cancelBt.isHidden = Bool
            self.stackViewUser.isHidden = !Bool
    }
    
    @objc func handleSelectorCancel(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0.005, options: [], animations: {
                self.searchBar.transform = CGAffineTransform(translationX: 0, y: -100)
                self.cancelBt.transform = CGAffineTransform(translationX: 100, y: 0)
            }, completion: { (finish: Bool) in
                if finish{
                    self.setUpTF(Bool: true)
                    self.setUpContraint()
                }
            })
            
        }
    }
    
    @objc func handleCancel(){
        Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(handleSelectorCancel), userInfo: nil, repeats: false)
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
                cell.setUpcell()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabBarCollectionView{
            if indexPath.item == index[indexPath.item]{
                number = numberOfItem[indexPath.item]
                listFoodCollectionView.reloadData()
            }
        }else{
            setStatusPopup(status: false)
        }
        
    }
    
    // setup Popup
    
    func setUpContraintPopUp(){
        
        blurBlackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        popUpView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
            make.width.equalTo(self.view.frame.width / 1.35)
            make.height.equalTo(self.view.frame.height / 2)
        }
    }
    
}

extension UIColor {
    static func rgb(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}

