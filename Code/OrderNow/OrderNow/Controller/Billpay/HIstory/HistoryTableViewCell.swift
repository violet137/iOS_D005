//
//  HistoryTableViewCell.swift
//  OrderNow
//
//  Created by admin on 12/17/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var lbBillName: UILabel!
    @IBOutlet weak var lbTableName: UILabel!
    @IBOutlet weak var lbTimePay: UILabel!
    @IBOutlet weak var lbStaffPay: UILabel!
    @IBOutlet weak var tableStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
