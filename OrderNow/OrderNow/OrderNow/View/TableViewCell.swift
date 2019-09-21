//
//  TableViewCell.swift
//  OrderNow
//
//  Created by admin on 9/5/19.
//  Copyright © 2019 ForLearn. All rights reserved.
//

import UIKit
import WWLayout

protocol BillDelegate {
    func increassNumber(cell: TableViewCell, number: Int)
    func decreassNumber(cell: TableViewCell, number: Int)
}

class TableViewCell: UITableViewCell {
    var delegate: BillDelegate?
    let minValue = 0
    
    static var identifier: String {
        return NSStringFromClass(self)
    }
    var bill : Bill? {
        didSet {
            foodImage.image = bill?.foodImage
            foodPrice.text = bill?.foodPrice
            foodNote.text = bill?.foodNote
            foodName.text = bill?.foodName
        }

    }
    
    private let foodImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "bittetbo"))
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    private let foodName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let foodNote: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let foodPrice: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textColor = .orange
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let quantity: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .orange
        lbl.numberOfLines = 0
        lbl.text = "1"
        return lbl
    }()
    
    private let minusButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("-", for: .normal)
        btn.setFont(size: 20, weight: .semibold)
        btn.setTitleColor(.orange, for: .normal)
        btn.layout.width(20).height(20)
        btn.setBorder(width: 1, color: .lightGray)
        btn.setRadius(radius: 10)
        btn.setShawdow(color: .black, width: 0.0, height: 2.0, radius: 1.0, opacity: 0.5)
        return btn
    }()
    
    private let addButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("+", for: .normal)
        btn.setFont(size: 20, weight: .semibold)
        btn.setTitleColor(.orange, for: .normal)
        btn.layout.width(20).height(20)
        btn.setBorder(width: 1, color: .lightGray)
        btn.setRadius(radius: 10)
        btn.setShawdow(color: .black, width: 0.0, height: 2.0, radius: 1.0, opacity: 0.5)
        return btn
    }()
    
    private let stackViewQuantity: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let stackViewFood: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.contentView.contentEdgeInsets = 
//        
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(foodImage)
        foodImage.layout.width(100).height(100)
            .leading(to: contentView, edge: .leading, offset: 10)
            .top(to: contentView, edge: .top, offset: 5)
        
        addSubview(stackViewFood)
        stackViewFood.addArrangedSubview(foodName)
        stackViewFood.addArrangedSubview(foodPrice)
        stackViewFood.addArrangedSubview(foodNote)
        stackViewFood.layout
            .leading(to: foodImage, edge: .trailing, offset: 10)
            .top(to: foodImage, edge: .top)
        addSubview(stackViewQuantity)
        stackViewQuantity.addArrangedSubview(addButton)
        stackViewQuantity.addArrangedSubview(quantity)
        stackViewQuantity.addArrangedSubview(minusButton)
        stackViewQuantity.translatesAutoresizingMaskIntoConstraints = false
        stackViewQuantity.layout
            .top(to: contentView, edge: .top, offset: 5)
            .leading(to: contentView, edge: .leading, offset: contentView.frame.width * 1.05)
        
        
        minusButton.addTarget(self, action: #selector(decreaseFunc), for:.touchUpInside)
        addButton.addTarget(self, action: #selector(increaseFunc), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func increaseFunc() {
        changeQuantity(by: 1)
    }
    
    @objc func decreaseFunc() {
        changeQuantity(by: -1)
    }
    
    func changeQuantity(by amount: Int) {
        var billQuantity = Int(quantity.text!)!
        billQuantity += amount
        if billQuantity < minValue {
            billQuantity = 0
            quantity.text = "0"
        } else {
            quantity.text = "\(billQuantity)"
        }
        delegate?.decreassNumber(cell: self, number: billQuantity)
    }
}
