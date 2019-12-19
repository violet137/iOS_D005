//
//  DetailHistoryFooterView.swift
//  OrderNow
//
//  Created by admin on 12/19/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class DetailHistoryFooterView: UITableViewHeaderFooterView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var detail: DetailHistoryTableViewController?
    
    @IBOutlet weak var btnBack: UIButton!
    static let reuseIdentifier: String = String(describing: self)
    
    @IBAction func actionBack(_ sender: Any) {
        detail?.dismiss(animated: true, completion: nil)
    }
    
}
