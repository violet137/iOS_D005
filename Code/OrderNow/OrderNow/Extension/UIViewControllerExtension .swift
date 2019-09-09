//
//  UIViewControllerExtension .swift
//  OrderNow
//
//  Created by ADMIN on 9/7/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
