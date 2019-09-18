//
//  ListFoodViewCell.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 8/24/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class ListFoodViewCell: UICollectionViewCell {
    
    @IBOutlet weak var giaTienLb: UILabel!
    @IBOutlet weak var tenLb: UILabel!
    @IBOutlet weak var imageImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpcell(){
        self.giaTienLb.layer.cornerRadius = 10.0
        self.imageImg.layer.cornerRadius = 10
        self.giaTienLb.clipsToBounds = true
        
    }

}
