import UIKit
extension UIColor{
    func rgb(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat){
        UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}
