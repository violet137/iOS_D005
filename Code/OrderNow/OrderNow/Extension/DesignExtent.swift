import UIKit

//Extension UIButton
extension UIButton {
    //set radius
    func setRadius(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    //set border
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func setFont(size: CGFloat, weight: UIFont.Weight) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    func setShawdow(color: UIColor, width: CGFloat, height: CGFloat, radius: CGFloat, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}

extension UILabel {
    //set radius
    func setRadius(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    //set border
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func setFont(size: CGFloat, weight: UIFont.Weight) {
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    func setShawdow(color: UIColor, width: CGFloat, height: CGFloat, radius: CGFloat, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}
