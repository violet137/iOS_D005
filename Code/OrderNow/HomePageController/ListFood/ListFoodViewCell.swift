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
    
    func setUpcell(data: Any){
        self.giaTienLb.layer.cornerRadius = 10.0
        self.imageImg.image = UIImage(named: "tomhum")
        self.giaTienLb.text = "85000"
        self.tenLb.text = "Tôm hùm nướng, rưới sốt bơ chanh tỏi"
        self.imageImg.layer.cornerRadius = 10
        self.giaTienLb.clipsToBounds = true
        
    }

}
