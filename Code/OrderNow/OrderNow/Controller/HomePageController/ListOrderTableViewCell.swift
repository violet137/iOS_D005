//
//  ListOrderTableViewCell.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 9/17/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class ListOrderTableViewCell: UITableViewCell {

    var tenMon = UILabel()
    var them = UIButton()
    var bot = UIButton()
    var soluong = UILabel()
    var stackVw = UIStackView()
    
    func setupContent(){
        addSubview(tenMon)
        tenMon.text = "hgfgfghvhgf"
        tenMon.layer.borderWidth = 1
        tenMon.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.width.equalTo(self.snp.width).dividedBy(1.8)
        }
        
        
        
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
