//
//  BookBeforeComeViewController.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 11/11/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseDatabase

class BookBeforeComeViewController: UIViewController {
    
    
    var bookTableVw = TableViewController()
    var navBarTitle = UILabel()
    var bookBefore = BookingBeforeUtils()
    let scrollView = UIScrollView()
    
    
    var bookingImg = UIImageView()
    var tgdenLb = UILabel()
    var tgDenTF = UITextField()
    var tenLb = UILabel()
    var tenTF = UITextField()
    var soluongLb = UILabel()
    var soluongTF = UITextField()
    var messageLb = UILabel()
    var messageTF = UITextField()
    var coverVw = UIView()
    var datePicker = UIDatePicker()
    
    var acceptBt = UIButton()
    
    var ref: DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        view.backgroundColor = .rgb(r: 245, g: 245, b: 245, a: 1)
        setupNavBar()
        setupContent()
        hideKeyboardWhenTappedAround()
        setupDatePicker()
    }
    
    
    func setupDatePicker(){
        datePicker.datePickerMode = .dateAndTime
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // set up button
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePickerDay))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDayPicker))
        toolbar.setItems([doneButton,space,cancelButton], animated: true)
        //add toolbar to TF
        tgDenTF.inputAccessoryView = toolbar
        //add datepicker to TF
        tgDenTF.inputView = datePicker
        tgDenTF.clearsOnInsertion = true
    }
    
    @objc func donePickerDay(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd-HH:mm"
        tgDenTF.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDayPicker(){
        self.view.endEditing(true)
    }
    
    @objc func acceptAct(){
        showSpinner(onView: self.view)
        UIButton.animate(withDuration: 0.25, animations: {
            self.acceptBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished: Bool) in
            if finished{
                self.acceptBt.transform = CGAffineTransform.identity
                self.addDonHang()
            }
        }
    }
    
    func paddingTf(tf: UITextField){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = paddingView
        tf.leftViewMode = UITextField.ViewMode.always
    }
    
    func addDonHang(){
        
        let name = tenTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let tgden = tgDenTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let soluong = soluongTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let message = messageTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if name != "" || tgden != "" || soluong != "" {
            let formatter = DateFormatter()
            let date = Date()
            formatter.dateFormat = "yyyy/MM/dd-HH:mm"
            let currentDate = formatter.string(from: date)
            if currentDate <= tgden{
                ref?.child("DatTruoc").childByAutoId().setValue(["message" : message, "so_nguoi" : Int(soluong)!, "status" : 1, "ten_kh" : name, "thoi_gian_den" : tgden])
                removeSpinner()
                dismiss(animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Opp!Error", message: "Không thể chọn ngày trước hôm nay!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: { (UIAlertAction) in
                    alert.dismiss(animated: true, completion: nil)
                    
                }))
                DispatchQueue.main.async {
                    self.removeSpinner()
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            let alert = UIAlertController(title: "Opp!Error", message: "Please fill all field!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: { (UIAlertAction) in
                alert.dismiss(animated: true, completion: nil)
                
            }))
            DispatchQueue.main.async {
                self.removeSpinner()
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    func setupNavBar(){
        navBarTitle.text = "Đặt Trước"
//        navBarTitle.textColor = .systemPink
        navigationController?.navigationBar.addSubview(navBarTitle)
        navBarTitle.snp.makeConstraints { (make) in
            make.center.equalTo((navigationController?.navigationBar.snp.center)!)
        }
        
    }
    
    
}


extension UITextField{
    func setUpFirst(){
        self.layer.cornerRadius = 5.0
        self.backgroundColor = .white
        self.layer.borderWidth = 0.5
    }
}


