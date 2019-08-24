//
//  TabBarViewCell.swift
//  OrderNow
//
//  Created by Duc'sMacBook on 8/24/19.
//  Copyright © 2019 Nguyen Thanh Phong. All rights reserved.
//

import UIKit

class TabBarViewCell: UICollectionViewCell{
    
    @IBOutlet weak var OptionLb: UILabel!
    @IBOutlet weak var imageImg: UIImageView!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var containerVw: UIView!
    @IBOutlet weak var stackVw: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setUpCell(){
        
        //        cell.iconImg.layer.cornerRadius = 18.0
        //        cell.iconImg.layer.borderWidth = 1.0
//        self.iconImg.layer.borderColor = UIColor.gray.cgColor
        self.OptionLb.text = "Tất cả"
        self.containerVw.layer.cornerRadius = 15.0
        self.backgroundColor = .clear // very important
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.23
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
    override var isSelected: Bool{
        didSet{
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = self.isSelected ? CGAffineTransform(scaleX: 1.1, y: 1.1) : CGAffineTransform.identity
                self.imageImg.image = self.isSelected ? UIImage(named: "bgbar") : UIImage()
                self.OptionLb.textColor = self.isSelected ? UIColor.white : UIColor.darkGray
                self.imageImg.layer.cornerRadius = 17.0
            }, completion: nil)
        }
    }
}
