//
//  StackViewExtension.swift
//  OrderNow
//
//  Created by ADMIN on 9/13/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

private var _backgroundViewColor = UIColor.clear
extension UIStackView {
    @IBInspectable var BackgroundView: UIColor {
        get {
            return _backgroundViewColor
        }
        set {
            _backgroundViewColor = newValue
            let subView = UIView(frame: bounds)
            subView.backgroundColor = _backgroundViewColor
            subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            insertSubview(subView, at: 0)
        }
    }
}
