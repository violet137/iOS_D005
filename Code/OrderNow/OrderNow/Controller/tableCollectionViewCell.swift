//
//  tableCollectionViewCell.swift
//  orderProject2
//
//  Created by Phu Vu on 9/5/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import UIKit

protocol TruyenVeManHinhTableTuCollectionViewCell {
    // func confirmDelete
}

class tableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableImageView: UIImageView!
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var chairLabel: UILabel!
    @IBOutlet weak var confirmAction: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func confirmDeleteTableAction(_ sender: Any) {
        let alert = UIAlertController(title: "Did you bring your towel?", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        //self.present(alert, animated: true)
    }
}
