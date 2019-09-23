//
//  tableCollectionViewCell.swift
//  orderProject2
//
//  Created by Phu Vu on 9/5/19.
//  Copyright © 2019 Phu Vu. All rights reserved.
//

import UIKit

protocol TruyenVeManHinhTableTuCollectionViewCell {
    func showAlert(cell: tableCollectionViewCell)
}

class tableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableImageView: UIImageView!
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var chairLabel: UILabel!
    @IBOutlet weak var confirmAction: UIButton!
    
   var delegate: TruyenVeManHinhTableTuCollectionViewCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func confirmDeleteTableAction(_ sender: Any) {
        
        delegate?.showAlert(cell: self)
    }
    
}
