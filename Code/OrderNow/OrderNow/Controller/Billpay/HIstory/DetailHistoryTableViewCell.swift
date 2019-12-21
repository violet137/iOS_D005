//
//  DetailHistoryTableViewCell.swift
//  OrderNow
//
//  Created by admin on 12/18/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class DetailHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbFoodName: UILabel!
    @IBOutlet weak var lbQuatity: UILabel!
    @IBOutlet weak var lbTotalPrice: UILabel!
    var detailView: DetailHistoryTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
