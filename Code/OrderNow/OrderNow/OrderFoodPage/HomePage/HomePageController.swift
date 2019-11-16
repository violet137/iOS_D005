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
import Firebase

class HomePageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, sentDataToList {
    
    func onDataUpdate() {
        DispatchQueue.global().async {
            self.listMonAn = self.monAnUtils.listMon
            self.listMonReturnNumberOfItem = self.listMonAn
            self.listMon1 = self.monAnUtils.FilterListMonAn(loai: 1)
            self.listMon2 = self.monAnUtils.FilterListMonAn(loai: 2)
            self.listMon3 = self.monAnUtils.FilterListMonAn(loai: 3)
            self.listMon4 = self.monAnUtils.FilterListMonAn(loai: 4)
            self.listMon5 = self.monAnUtils.FilterListMonAn(loai: 5)
            self.listTong.append(self.listMonAn)
            self.listTong.append(self.listMon1)
            self.listTong.append(self.listMon2)
            self.listTong.append(self.listMon3)
            self.listTong.append(self.listMon4)
            self.listTong.append(self.listMon5)
            self.makeContraintPopupOrder()
        }
        DispatchQueue.main.async {
            
            self.listFoodCollectionView.reloadData()
            self.tabBarCollectionView.reloadData()
            self.tenBanLb.text = self.banid
            let indexPath = NSIndexPath(item: 0, section: 0)
            self.tabBarCollectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .init())
            
        }
        self.removeSpinner()
    }
    
    // protocol func
    func sentData(user: GIDGoogleUser) {
        
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
    @IBOutlet weak var tenBanLb: UILabel!
    
    //variable blabla....
    
    var nameTabList = ["Tất cả", "Bún", "Nướng", "Cơm", "Súp", "Bánh"]
    
    var ref: DatabaseReference!
    var monAnUtils = MonAnUtils()
    var listMonAn = [MonAn]()
    var listMonReturnNumberOfItem = [MonAn]()
    
    var listMon1 = [MonAn]()
    var listMon2 = [MonAn]()
    var listMon3 = [MonAn]()
    var listMon4 = [MonAn]()
    var listMon5 = [MonAn]()
    var listTong = [[MonAn]]()
    var banid = ""
    
    let popUpView = UIView()
    let blurBlackView = UIView()
    var searchBar = UISearchBar()
    var cancelBt = UIButton()
    let coverVw = UIView()
    let popupOrder = UIView()
        // các thành phần trong Popup chọn món
        let popupImg = UIImageView()
        let popupFoodNameLb = UILabel()
        let costLb = UILabel()
        let moreBt = UIButton()
        let lessBt = UIButton()
        let amountLb = UILabel()
        let addToOrderListBt = UIButton()
        let cancelPopupBt = UIButton()
        var popupImgName: String?
        //các thành phần trong popup oderlist
        let infoTableLb = UILabel()
        lazy var listOderTBV: ListOderTableView = {
            let tbv = ListOderTableView()
            return tbv
        }()
        let dismissOderPopup = UIButton()
        let acceptOder = UIButton()
    //Viewdidload func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showSpinner(onView: self.view)
        monAnUtils.getDataFromFireBase()
        monAnUtils.delegate = self
        setUpSomethingElse()
        setUpContraintNavigationBar()
        conectCollectionView()
        setUpPopUp()
        makeContraintInPopupView()
        
        setUpContraintOfContentInPopupOder()
    }
    
    //contraint các thứ
    
    @IBAction func xacNhanOderAct(_ sender: Any) {
        popUpIsClose(status: false, location: false)
    }
    
    func makeContraintPopupOrder(){
        DispatchQueue.main.async {
            self.view.addSubview(self.popupOrder)
            self.popupOrder.backgroundColor = .white
            self.popupOrder.isHidden = true
            self.popupOrder.snp.makeConstraints { (make) in
                make.height.equalTo(self.view.snp.height).dividedBy(1.2)
                make.width.equalTo(self.view.snp.width).dividedBy(1.1)
                make.center.equalTo(self.view.snp.center)
            }
        }
    }
    
    func setUpContraintOfContentInPopupOder(){
        popupOrder.addSubview(infoTableLb)
        popupOrder.addSubview(listOderTBV)
        popupOrder.addSubview(dismissOderPopup)
        popupOrder.addSubview(acceptOder)
        
        infoTableLb.text = "Bàn Số: ?"
        infoTableLb.snp.makeConstraints { (make) in
            make.top.equalTo(popupOrder.snp.top).offset(10)
            make.centerX.equalTo(popupOrder.snp.centerX)
            make.height.equalTo(40)
        }
        
        listOderTBV.snp.makeConstraints { (make) in
            make.top.equalTo(infoTableLb.snp.bottom).offset(20)
            make.width.equalTo(popupOrder.snp.width)
            make.bottom.equalTo(popupOrder.snp.bottom).inset(60)
        }
        
        dismissOderPopup.setTitle("Dismiss", for: .normal)
        dismissOderPopup.setTitleColor(.black, for: .normal)
        dismissOderPopup.backgroundColor = .red
        dismissOderPopup.layer.cornerRadius = 5.0
        dismissOderPopup.addTarget(self, action: #selector(handleDismissOrderPopupBt), for: .touchUpInside)
        dismissOderPopup.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.leading.equalTo(popupOrder.snp.leading).inset(5)
            make.trailing.equalTo(acceptOder.snp.leading).offset(-5)
            make.bottom.equalTo(popupOrder.snp.bottom).inset(7)
            make.width.equalTo(acceptOder.snp.width)
        }
        
        acceptOder.setTitle("OderNow", for: .normal)
        acceptOder.backgroundColor = .green
        acceptOder.setTitleColor(.black, for: .normal)
        acceptOder.layer.cornerRadius = 5.0
        acceptOder.snp.makeConstraints { (make) in
            make.trailing.equalTo(popupOrder.snp.trailing).inset(5)
            make.top.equalTo(dismissOderPopup.snp.top)
            make.height.equalTo(dismissOderPopup.snp.height)
            make.width.equalTo(dismissOderPopup.snp.width)
//            make.leading.equalTo(dismissOderPopup.snp.trailing)
        }
        acceptOder.addTarget(self, action: #selector(handleAcceptOrder), for: .touchUpInside)
        
    }
    
    @objc func handleAcceptOrder(){
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseOut, animations: {
            self.popupOrder.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            self.popUpIsClose(status: true, location: false)
        }
        UIButton.animate(withDuration: 0.25, animations: {
            self.dismissOderPopup.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            if finished{
                self.dismissOderPopup.transform = CGAffineTransform.identity
            }
        }
        
        print(listOderTBV.ListOrder)
        ref = Database.database().reference()
        for item in listOderTBV.ListOrder{
            ref.child("ListOrder").child(banid ?? "").child(item.tenMon!).setValue(["name": item.tenMon, "hinh": item.hinh, "gia1Mon": item.gia1Mon, "soLuong": item.soLuongDat])
        }
        
    }
    
    @objc func handleDismissOrderPopupBt(){
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseOut, animations: {
            self.popupOrder.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            self.popUpIsClose(status: true, location: false)
        }
        UIButton.animate(withDuration: 0.25, animations: {
            self.dismissOderPopup.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            if finished{
                self.dismissOderPopup.transform = CGAffineTransform.identity
            }
        }
    }
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
            popUpView.addSubview(addToOrderListBt)
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
            
            coverVw2.addSubview(addToOrderListBt)
            addToOrderListBt.setTitle("Add to Oder", for: .normal)
            addToOrderListBt.layer.cornerRadius = 5.0
            addToOrderListBt.backgroundColor = UIColor.rgb(r: 50, g: 205, b: 50, a: 1)
            addToOrderListBt.snp.makeConstraints { (make) in
                make.centerY.equalTo(cancelPopupBt)
                make.centerX.equalTo(coverVw)
                make.width.equalTo(cancelPopupBt)
            }
            
            // các tính năng của các nút
            
            cancelPopupBt.addTarget(self, action: #selector(handleCancelPopupBt), for: .touchUpInside)
            addToOrderListBt.addTarget(self, action: #selector(handleAddToOrderListBt), for: .touchUpInside)
            moreBt.addTarget(self, action: #selector(handleMoreBt), for: .touchUpInside)
            lessBt.addTarget(self, action: #selector(handleLessBt), for: .touchUpInside)
        }
    
    //Và đây là tính năng TRONG popUp
    
    @objc func handleCancelPopupBt(){
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseOut, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            self.popUpIsClose(status: true, location: true)
        }
        UIButton.animate(withDuration: 0.25, animations: {
            self.cancelPopupBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            if finished{
                self.cancelPopupBt.transform = CGAffineTransform.identity
            }
        }
        
        amount = 1
        
    }
    
    @objc func handleAddToOrderListBt(){
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseOut, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            self.popUpIsClose(status: true, location: true)
        }
        UIButton.animate(withDuration: 0.25, animations: {
            self.addToOrderListBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            if finished{
                self.addToOrderListBt.transform = CGAffineTransform.identity
            }
        }
        // do something else
        
        let dump = OrderModal(ten: popupFoodNameLb.text!, soluong: amount, hinh: popupImgName!, gia1Mon: Double(gia1Mon))
        listOderTBV.ListOrder.append(dump)
        listOderTBV.tableView.reloadData()
        amount = 1
    }
    
    @objc func handleMoreBt(){
        if amount >= 0 && amount < 10{
            amount += 1
            self.amountLb.text = "\(self.amount)"
            costLb.text = "\(amount * gia1Mon) đ"
        }
    }
    
    var gia1Mon = 0
    var amount = 1
    
    @objc func handleLessBt(){
        if amount > 0 && amount <= 10{
            amount -= 1
            amountLb.text = "\(amount)"
            costLb.text = "\(amount * gia1Mon) đ"
        }
    }
    
    // Và đây là tính năng CỦA popup
    
    fileprivate func setUpPopUp() {
        self.view.addSubview(blurBlackView)
        self.view.addSubview(popUpView)
        setUpContraintPopUp()
        popUpIsClose(status: true, location: true)
        blurBlackView.backgroundColor = UIColor.rgb(r: 0, g: 0, b: 0, a: 0.5)
        popUpView.backgroundColor = .white
        blurBlackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCancelPopup)))
        popUpView.layer.cornerRadius = 10
    }
    
    @objc func handleCancelPopup(){
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseOut, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.popupOrder.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            self.popUpIsClose(status: true, location: true)
            self.popUpIsClose(status: true, location: false)
        }
    }
    
    //Hàm kiểm tra trạng thái xuất hiện của popupView
    fileprivate func popUpIsClose(status: Bool, location: Bool) {
        if location == true{
            popUpView.isHidden = status
        }else{
            popupOrder.isHidden = status
        }
        blurBlackView.isHidden = status
        UIView.animate(withDuration: 0.3, delay: 0.005, options: .curveEaseOut, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.popupOrder.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (finished: Bool) in
            self.popUpView.transform = CGAffineTransform.identity
            self.popupOrder.transform = CGAffineTransform.identity
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
    
    @IBAction func backAct(_ sender: Any) {
        
        var naviController = UINavigationController(rootViewController: ListBookBeforeComeViewController())
        present(naviController, animated: true, completion: nil)
//        dismiss(animated: true, completion: nil)
    }
    
        func setUpHiddenOrNot(Bool: Bool){
            self.backBt.isHidden = !Bool
            self.searchBt.isHidden = !Bool
            self.searchBar.isHidden = Bool
            self.cancelBt.isHidden = Bool
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
    
//        @IBAction func nameUserAct(_ sender: Any) {
//        }
//
//        @IBAction func tapToImgUserAct(_ sender: Any) {
//        }
    
    //Và đây là hàm dùng để kết nối collectionView
    
    func conectCollectionView(){
        listFoodCollectionView.delegate = self
        listFoodCollectionView.dataSource = self
        tabBarCollectionView.delegate = self
        tabBarCollectionView.dataSource = self
        tabBarCollectionView.register(UINib(nibName: "TabBarViewCell", bundle: nil), forCellWithReuseIdentifier: "tabbartop")
        listFoodCollectionView.register(UINib(nibName: "ListFoodViewCell", bundle: nil), forCellWithReuseIdentifier: "listfood")
        
        
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
            return listTong.count
        }else{
            return listMonReturnNumberOfItem.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabBarCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabbartop", for: indexPath) as? TabBarViewCell else {
                return UICollectionViewCell()
            }
            DispatchQueue.main.async {
                cell.nameTabLb.text = self.nameTabList[indexPath.item]
                cell.setUpCell()
            }
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listfood", for: indexPath) as? ListFoodViewCell else{
                return UICollectionViewCell()
            }
            
            let data = listMonReturnNumberOfItem[indexPath.item]
            cell.tenLb.text = data.tenMonAn
            cell.giaTienLb.text = String(data.giaTien!)
            cell.imageImg.image = UIImage(named: data.hinh!)
            cell.setUpcell()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabBarCollectionView{
            listMonReturnNumberOfItem = listTong[indexPath.item]
            listFoodCollectionView.reloadData()
        }else{
            popUpIsClose(status: false, location: true)
            amountLb.text = String(amount)
            gia1Mon = Int(listMonReturnNumberOfItem[indexPath.item].giaTien!)
            popupFoodNameLb.text = listMonReturnNumberOfItem[indexPath.item].tenMonAn
            costLb.text = String(listMonReturnNumberOfItem[indexPath.item].giaTien!)
            popupImg.image = UIImage(named: listMonReturnNumberOfItem[indexPath.item].hinh!)
            popupImgName = listMonReturnNumberOfItem[indexPath.item].hinh!
        }
    }
}

// extend lại cho dễ dùng :))
extension UIColor {
    static func rgb(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}


