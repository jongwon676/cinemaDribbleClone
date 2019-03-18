import UIKit
extension UIStackView {
    convenience init(arrangedSubviews: [UIView], spacing:CGFloat = 0){
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = spacing
    }
}
