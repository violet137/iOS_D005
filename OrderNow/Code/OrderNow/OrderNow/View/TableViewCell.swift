//
//  TableViewCell.swift
//  OrderNow
//
//  Created by admin on 9/5/19.
//  Copyright © 2019 ForLearn. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static var identifier: String {
        return NSStringFromClass(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
