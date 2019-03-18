import UIKit
extension UILabel {
    convenience init(font: UIFont, textColor: UIColor, numberOfLines: Int = 1){
        self.init(frame: .zero)
        self.font = font
        self.numberOfLines = numberOfLines
        self.textColor = textColor
    }
}
