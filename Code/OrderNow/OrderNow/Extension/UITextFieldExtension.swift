//
//  UITextFieldExtension.swift
//  OrderNow
//
//  Created by ADMIN on 9/7/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

private var _maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = _maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            _maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        let v = t!.prefix(maxLength)
        textField.text = v.description
    }
}
